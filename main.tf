# account information
data "aws_caller_identity" "current" {}

# template file for config role trust
data "template_file" "config_role_trust_policy_tpl" {
  template = "${file("${path.module}/policies/config-role-trust-policy.tpl")}"
}

# template file for role bucket access
data "template_file" "config_role_s3_bucket_policy_tpl" {
  template = "${file("${path.module}/policies/config-bucket-policy.tpl")}"

  vars {
    config_bucket_arn = "${aws_s3_bucket.config_bucket.arn}"
    account_id        = "${data.aws_caller_identity.current.account_id}"
  }
}

# template file for role sns publish
data "template_file" "config_role_snspublish_policy_tpl" {
  template = "${file("${path.module}/policies/config-role-snspublish-policy.tpl")}"

  vars {
    config_sns_arn = "${aws_sns_topic.config_sns_topic.arn}"
    config_sns_dr_arn = "${aws_sns_topic.config_sns_topic_dr.arn}"
  }
}

# template file for bucket replication role trust
data "template_file" "config_bucket_repl_role_trust_policy_tpl" {
  template = "${file("${path.module}/policies/config-bucket-repl-role-trust-policy.tpl")}"
}

# template file for bucket replication role policy
data "template_file" "config_bucket_repl_role_policy_tpl" {
  template = "${file("${path.module}/policies/config-bucket-repl-role-policy.tpl")}"

  vars {
    config_bucket_arn    = "${aws_s3_bucket.config_bucket.arn}"
    config_bucket_dr_arn = "${aws_s3_bucket.config_bucket_dr.arn}"
  }
}

# aws config recorder
resource "aws_config_configuration_recorder" "config_recorder" {
  name       = "default"
  role_arn   = "${aws_iam_role.config_role.arn}"

  recording_group = {
    all_supported                 = true
    include_global_resource_types = true
  }
  depends_on = ["aws_s3_bucket.config_bucket"]
}

# aws config delivery channel
resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = "default"
  s3_bucket_name = "${aws_s3_bucket.config_bucket.bucket}"
  sns_topic_arn  = "${aws_sns_topic.config_sns_topic.arn}"
  depends_on     = ["aws_config_configuration_recorder.config_recorder"]
}

# aws config s3 bucket - prod
resource "aws_s3_bucket" "config_bucket" {
  provider      = "aws.audit-prod"
  force_destroy = true
  bucket        = "tiaa-${var.account_alias}-config-logs-prod"
}

# aws config s3 bucket policy
resource "aws_s3_bucket_policy" "config_bucket_policy" {
  provider = "aws.audit-prod"
  bucket   = "${aws_s3_bucket.config_bucket.id}"
  policy   = "${data.template_file.config_role_s3_bucket_policy_tpl.rendered}"
}

# enable the aws config recorder - recorder and delivery channel required!
resource "aws_config_configuration_recorder_status" "config_recorder_status" {
  name       = "${aws_config_configuration_recorder.config_recorder.name}"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.config_delivery_channel"]
}

# aws config iam role
resource "aws_iam_role" "config_role" {
  name               = "${var.account_alias}-config-role"
  assume_role_policy = "${data.template_file.config_role_trust_policy_tpl.rendered}"
}

# aws config iam AWS managed policy attach - AWSConfigRole
resource "aws_iam_role_policy_attachment" "config_managed_policy" {
  role       = "${aws_iam_role.config_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

# aws config iam policy for config sns
resource "aws_iam_policy" "config_sns_policy" {
  name        = "${var.account_alias}-config-role-deliverypermissions-${var.aws_region}"
  description = "IAM Policy to allow sns:Publish to an SNS topic from AWS Config"
  policy      = "${data.template_file.config_role_snspublish_policy_tpl.rendered}"
}

# aws config iam managed policy attach
resource "aws_iam_role_policy_attachment" "config_sns_policy" {
  role       = "${aws_iam_role.config_role.id}"
  policy_arn = "${aws_iam_policy.config_sns_policy.arn}"
}

# aws config sns topic
resource "aws_sns_topic" "config_sns_topic" {
  name = "${var.account_alias}-config-topic-${var.aws_region}"
}

# aws config sqs queue
resource "aws_sqs_queue" "config_sqs_queue" {
  name = "${var.account_alias}-config-queue-${var.aws_region}"
}

# aws config sns topic subscription for sqs
resource "aws_sns_topic_subscription" "config_topic_subscription" {
  topic_arn = "${aws_sns_topic.config_sns_topic.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.config_sqs_queue.arn}"
}
