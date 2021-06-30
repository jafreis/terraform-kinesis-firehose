resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.stream_name
  destination = "extended_s3"

  extended_s3_configuration {
    dynamic "cloudwatch_logging_options" {
      for_each = (length(var.cloudwatch_logging_options) > 0) ? [] : [var.cloudwatch_logging_options]

      content {
        enabled = lookup(cloudwatch_logging_options.value, "cloudwatch_logging_enabled", false)
        log_group_name = lookup(cloudwatch_logging_options.value, "log_group_name", null)
        log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
      }
    }

    dynamic "processing_configuration" {
      for_each = var.processing_configuration

      content {
        enabled = lookup(processing_configuration.value, "processing_configuration_enabled", false)
        processors {
          type = lookup(processing_configuration.value, "processors_type", null)
          parameters {
            parameter_name = lookup(processing_configuration.value, "processors_parameter_name", null)
            parameter_value = lookup(processing_configuration.value, "processors_parameter_value", null)
          }
        }
      }
    }

    dynamic "s3_backup_configuration" {
      for_each = var.s3_backup_configuration

      content {
        role_arn   = lookup(s3_backup_configuration.value, "role_arn", null)
        bucket_arn = lookup(s3_backup_configuration.value, "bucket_arn", null)
        prefix = lookup(s3_backup_configuration.value, "bucket_prefix", null)
        buffer_size = lookup(s3_backup_configuration.value, "buffer_size", null)
        buffer_interval = lookup(s3_backup_configuration.value, "buffer_interval", null)
        compression_format = lookup(s3_backup_configuration.value, "compression_format", null)
        kms_key_arn = lookup(s3_backup_configuration.value, "kms_key_arn", null)
      }
    }

    role_arn   = var.firehose_role_arn
    bucket_arn = var.bucket_arn
    prefix = var.bucket_prefix
    buffer_size = var.buffer_size
    buffer_interval = var.buffer_interval
    compression_format = var.compression_format
    kms_key_arn = var.kms_key_arn
  }

  tags = var.tags
}

