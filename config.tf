provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/18"
}

# Output variable
output "address" {
  value = "${aws_elb.web.dns_name}"
}

# Example variable
variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-1"
}

# Ubuntu Precise 12.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-cb03e0f1e"
    us-east-1 = "ami-1d4969a6"
    us-west-1 = "ami-b1f61d4"
    us-west-2 = "ami-d4969880"
  }
}

# Built-in function
resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
