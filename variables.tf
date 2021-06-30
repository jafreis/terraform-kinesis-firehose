variable "stream_name" {
  description = "A name to identify the stream. This is unique to the AWS account and region the Stream is created in."
  type = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type = map
  default = {}
}

variable "firehose_role_arn" {
  description = "The ARN of the AWS credentials."
  type = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket"
  type = string
  default = ""
}

variable "bucket_prefix" {
  description = "The 'YYYY/MM/DD/HH' time format prefix is automatically used for delivered S3 files. You can specify an extra prefix to be added in front of the time format prefix. Note that if the prefix ends with a slash, it appears as a folder in the S3 bucket"
  type = string
  default = null
}

variable "buffer_size" {
  description = "Buffer incoming data to the specified size, in MBs, before delivering it to the destination. The default value is 5. We recommend setting SizeInMBs to a value greater than the amount of data you typically ingest into the delivery stream in 10 seconds. For example, if you typically ingest data at 1 MB/sec set SizeInMBs to be 10 MB or higher."
  type = number
  default = 5
}

variable "buffer_interval" {
  description = "Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination. The default value is 300."
  type = number
  default = 300
}

variable "compression_format" {
  description = "The compression format. If no value is specified, the default is UNCOMPRESSED. Other supported values are GZIP, ZIP & Snappy. If the destination is redshift you cannot use ZIP or Snappy."
  type = string
  default = "UNCOMPRESSED"
}

variable "kms_key_arn" {
  description = "Specifies the KMS key ARN the stream will use to encrypt data. If not set, no encryption will be used."
  type = string
  default = ""
}

variable "error_output_prefix" {
  description = "Prefix added to failed records before writing them to S3. This prefix appears immediately following the bucket name."
  type = string
  default = ""
}

variable "s3_backup_mode" {
  description = "The Amazon S3 backup mode. Valid values are Disabled and Enabled. Default value is Disabled."
  type = string
  default = "Disabled"
}

variable "processing_configuration" {
  description = "The data processing configuration"
  type = map
  default = {}
}

variable "s3_backup_configuration" {
  description = "The configuration for backup in Amazon S3. Required if s3_backup_mode is Enabled. Supports the same fields as s3_configuration object."
  type = map
  default = {}
}

variable "cloudwatch_logging_options" {
  description = "The CloudWatch Logging Options for the delivery stream."
  type = map
  default = {}
}

