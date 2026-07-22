#########################################
# VPC Flow Logs
#########################################

resource "aws_flow_log" "vpc" {
  vpc_id = aws_vpc.this.id

  traffic_type         = "ALL"
  log_destination_type = "s3"
  log_destination      = "${var.flow_logs_bucket_arn}/vpc-flow-logs"

  max_aggregation_interval = 60

  destination_options {
    file_format                = "parquet"
    hive_compatible_partitions = true
    per_hour_partition         = true
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-vpc-flow-logs"
    }
  )
}
