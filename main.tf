# Set up the AWS provider
provider "aws" {
  region = "us-west-2"  # Set the desired AWS region
}

# Define variables for the event themes and your initials
variable "event_themes" {
  default = ["AdventureTech", "NatureEscape", "DataSummit", "CodeCarnival"]
}

variable "initials" {
  default = "JS"  # Replace with your own initials
}

# Iterate over the event themes to create S3 buckets
resource "aws_s3_bucket" "event_buckets" {
  count = length(var.event_themes)

  bucket = "${var.event_themes[count.index]}-${var.initials}-bucket"
  acl    = "private"
  region = "us-west-2"

  tags = {
    Name    = "${var.event_themes[count.index]}-${var.initials}-bucket"
    Theme   = var.event_themes[count.index]
    Initials = var.initials
  }
}

# Output the names of the created buckets
output "created_bucket_names" {
  value = aws_s3_bucket.event_buckets[*].bucket
}

