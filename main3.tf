provider "aws" {
  region     = "ca-central-1"
}

##This will store in S3 bucket
  terraform {
    backend "s3" {
    bucket = "bucketforterrastate"
    key    = "terraform.tfstate"
    region = "ca-central-1"
    dynamodb_table = "terraclass2lock"
  }
}

##This will provision an EC2 instance using a module
module "my_ec2" {
  source = "./ec2-module" 
}

##This will provision VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

##This will provision a security group
resource "aws_security_group" "mysg" {
  description = "Allow HTTPS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg"
  }
}

