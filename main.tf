terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# if you did aws configure
# it will take credentials from .aws/config file

provider "aws" {
  region = "ap-south-1"
}


# we need to create the instance in the default vpc and subnet. 
# so we don't have to specify any vpc or subnet. 
# terraform will automatically create the instance in the default unless specified

resource "aws_instance" "instance1" {
  ami                     = "ami-08e5424edfe926b43"
  instance_type           = "t2.micro"
  key_name                = "Avam"
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-0f33201aaee3c26e2"]
  tags = {
    Terraform   = "true"
    Env = "prod"
  }
}

# one instance will be created