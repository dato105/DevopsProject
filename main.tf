terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "ca-central-1"
}

resource "aws_vpc" "david-sharaby-dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "david-sharaby-dev-vpc"
  }
}
resource "aws_subnet" "david-sharaby-k8s-subnet" {
  vpc_id     = aws_vpc.david-sharaby-dev-vpc.id 
  cidr_block = "10.0.1.0/27"
  tags = {
    Name = "david-sharaby-dev-vpc"
    }




}
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.david-sharaby-dev-vpc.id
  tags = {
    Name = "instance-gateway"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.david-sharaby-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}