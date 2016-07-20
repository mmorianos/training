#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-5a424367
#
# Your security group ID is:
#
#     sg-ca91a0b1
#
# Your AMI ID is:
#
#     ami-db24d8b6
#
# Your Identity is:
#
#     manheim-c20ad4d76fe97759aa27a0c99bff6710
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
    default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "web" {
    count = "2"
    ami = "ami-db24d8b6"
    instance_type = "t2.micro"
    subnet_id = "subnet-5a424367"
    vpc_security_group_ids = ["sg-ca91a0b1"]
    tags {
        Identity = "manheim-c20ad4d76fe97759aa27a0c99bff6710"
        Owner = "Michael Morianos"
        OwnerEmail = "michael.morianos@coxautoinc.com"
    }
}

output "public_ip" {
  value = "${join(", ", aws_instance.web.*.public_ip)}"
}

output "public_dns" {
  value = "${join(", ", aws_instance.web.*.public_dns)}"
}
