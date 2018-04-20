output "config_bucket_id" {
  value = "${aws_s3_bucket.config_bucket.id}"
}

output "config_sns_topic_id" {
  value = "${aws_sns_topic.config_sns_topic.arn}"
}

output "config_sqs_queue_id" {
  value = "${aws_sqs_queue.config_sqs_queue.arn}"
}

output "config_role_id" {
  value = "${aws_iam_role.config_role.name}"
}

output "config_recorder_id" {
  value = "${aws_config_configuration_recorder.config_recorder.name}"
}

output "config_delivery_channel_id" {
  value = "${aws_config_delivery_channel.config_delivery_channel.name}"
}
