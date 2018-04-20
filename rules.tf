resource "aws_config_config_rule" "managed-rule-01" {
  name        = "S3_BUCKET_VERSIONING_ENABLED"
  description = "Checks whether versioning is enabled for your S3 buckets. Optionally, the rule checks if MFA delete is enabled for your S3 buckets."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }
}

resource "aws_config_config_rule" "managed-rule-02" {
  name        = "S3_BUCKET_LOGGING_ENABLED"
  description = "Checks whether logging is enabled for your S3 buckets."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "managed-rule-03" {
  name        = "REQUIRED_TAGS"
  description = "Checks whether your resources have the tags that you specify. For example, you can check whether your EC2 instances have the 'CostCenter' tag. Separate multiple values with commas."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  #Convert this to a list later
  input_parameters = "{\"tag1Key\": \"Name\",\"tag2Key\": \"Owner\",\"tag3Key\": \"BudgetCode\"}"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }
}

resource "aws_config_config_rule" "managed-rule-04" {
  name             = "IAM_PASSWORD_POLICY"
  description      = "Checks whether the account password policy for IAM users meets the specified requirements."
  input_parameters = "{\"RequireUppercaseCharacters\":\"true\",\"RequireLowercaseCharacters\":\"true\",\"RequireSymbols\":\"true\",\"RequireNumbers\":\"true\",\"MinimumPasswordLength\":\"8\",\"PasswordReusePrevention\":\"false\",\"MaxPasswordAge\":\"120\"}"
  depends_on       = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }
}

resource "aws_config_config_rule" "managed-rule-05" {
  name        = "IAM_USER_NO_POLICIES_CHECK"
  description = "Checks that none of your IAM users have policies attached. IAM users mucy inherit permisions from IAM groups or roles."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }
}

resource "aws_config_config_rule" "managed-rule-06" {
  name        = "ROOT_ACCOUNT_MFA_ENABLED"
  description = "Checks whether the root user of your AWS account requires multi-factor authentication for console sign-in."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "managed-rule-07" {
  name        = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  description = "Checks that your S3 buckets do not allow public write access. If an S3 bucket policy or bucket ACL allows public write access, the bucket is noncompliant."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
}

resource "aws_config_config_rule" "managed-rule-08" {
  name        = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  description = "Checks whether AWS CloudTrail is enabled in your AWS account. Optionally, you can specify which S3 bucket, SNS topic, and Amazon CloudWatch Logs ARN to use."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
}

resource "aws_config_config_rule" "managed-rule-09" {
  name        = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  description = "Checks whether the S3 bucket policy denies the S3:PutObject requests that are not encrypted using AES-256 or AWS KMS."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "managed-rule-10" {
  name        = "EIP_ATTACHED"
  description = "Checks whether all EIP addresses allocated to a VPC are attached to EC2 instances or in-use ENI's."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  depends_on = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }
}

resource "aws_config_config_rule" "managed-rule-11" {
  name        = "EC2_INSTANCE_DETAILED_MONITORING_ENABLED"
  description = "Checks whether detailed monitoring is enabled for EC2 instances."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_DETAILED_MONITORING_ENABLED"
  }
}

resource "aws_config_config_rule" "managed-rule-12" {
  name        = "INSTANCES_IN_VPC"
  description = "Checks whether your EC2 instances belong to a virtual private cloud (VPC). Optionally, you can specify the VPC ID to associate with your instances."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }
}

resource "aws_config_config_rule" "managed-rule-13" {
  name        = "EC2_VOLUME_INUSE_CHECK"
  description = "Checks whether EBS volumes are attached to EC2 instances. Optionally checks if EBS volumes are marked for deletion when an instance is terminated."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }
}

resource "aws_config_config_rule" "managed-rule-14" {
  name        = "ENCRYPTED_VOLUMES"
  description = "Checks whether EBS volumes that are in an attached state are encrypted. Optionally, you can specify the ID of a KMS key to use to encrypt the volume."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }
}

resource "aws_config_config_rule" "managed-rule-15" {
  name             = "RESTRICTED_INCOMING_TRAFFIC"
  description      = "Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports."
  depends_on       = ["aws_config_configuration_recorder.config_recorder"]
  input_parameters = "{\"blockedPort1\": \"20\", \"blockedPort2\": \"21\", \"blockedPort3\": \"3389\", \"blockedPort4\": \"3306\", \"blockedPort5\": \"4333\"}"

  source {
    owner             = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }
}

resource "aws_config_config_rule" "managed-rule-16" {
  name        = "INCOMING_SSH_DISABLED"
  description = "Checks whether security groups that are in use disallow unrestricted incoming SSH traffic."
  depends_on  = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }
}

resource "aws_config_config_rule" "managed-rule-17" {
  name             = "CLOUD_TRAIL_ENABLED"
  description      = "Checks whether AWS CloudTrail is enabled in your AWS account. Optionally, you can specify which S3 bucket, SNS topic, and Amazon CloudWatch Logs ARN to use."
  depends_on       = ["aws_config_configuration_recorder.config_recorder"]

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }
}
