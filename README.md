# AWS Config - Config Baseline with AWS Managed Rules

Config_Baseline creates the base configuration for AWS Config with logging being delivered into a dedicated bucket in the same region. Messages are also delivered to a region specific SNS Topic and a region specific SQS queue is subscribed (if selected).

## Resources Created

1. AWS Config - S3 Bucket
1. AWS Config - Recorder
1. AWS Config - Delivery Channel
1. AWS Config - IAM Role
1. AWS Config - Trust Policy
1. AWS Config - SNS Topic
1. AWS Config - sns:Publish Policy
1. AWS Config - SQS Queue
1. AWS Config - SQS Subscription to SNS Topic

## Config Managed Rules Created

1. S3_BUCKET_VERSIONING_ENABLED
1. S3_BUCKET_LOGGING_ENABLED
1. REQUIRED_TAGS
    * Name
    * Description
    * BudgetCode
    * Owner
1. IAM_PASSWORD_POLICY
    * RequireUppercaseCharacters:true
    * RequireLowercaseCharacters:true
    * RequireSymbols:true
    * RequireNumbers:true
    * MinimumPasswordLength:8
    * PasswordReusePrevention:true
    * MaxPasswordAge:120
1. IAM_USER_NO_POLICIES_CHECK
1. ROOT_ACCOUNT_MFA_ENABLED
1. S3_BUCKET_PUBLIC_READ_PROHIBITED
1. S3_BUCKET_PUBLIC_WRITE_PROHIBITED
1. S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED
1. EIP_ATTACHED
1. EC2_INSTANCE_DETAILED_MONITORING_ENABLED
1. INSTANCES_IN_VPC
1. EC2_VOLUME_INUSE_CHECK
1. ENCRYPTED_VOLUMES
1. RESTRICTED_INCOMING_TRAFFIC
    * blockedPort1:20
    * blockedPort2:21
    * blockedPort3:3389
    * blockedPort4:3306
    * blockedPort5:4333
1. INCOMING_SSH_DISABLED
1. CLOUD_TRAIL_ENABLED
    1. s3BucketName
    1. snsTopicArn
    1. cloudWatchLogsLogGroupArn
