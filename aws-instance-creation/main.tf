terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  #region = "us-east-1"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"
  key_name      = "ServersKey"
  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name    = "NewUbuntuInstance"
    Owner   = "Valerii Vasianovych"
    Project = "AWS Instance Creation"
  }
}

resource "aws_security_group" "instance" {
  name        = "terraform_example_instance"
  description = "An example security group for Terraform"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}