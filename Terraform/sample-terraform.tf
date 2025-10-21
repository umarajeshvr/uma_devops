Terraform {
 required providers {
    aws = {
    source = "hashicorp/aws"
    version = "~>6.0"
    }
 }
}
 provider "aws" {
    Region = "us-east-1"
 }
 #VPC
 resource "aws_vpc" "my_vpc" {
    Cidr_block = "0.0.0.0/0"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"

    tags = {
        Name = "my_vpc"
    }
 }
#Internet gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = "aws_vpc.my_vpc"

    tags = {
        Name = "my-igw"
    } 
}
#public subnet
resource "aws_public_subnet" "public_subnet" {
    vpc_id = "aws_vpc.my_vpc"
    availability_zone "us-east-a"
    map_puplic_ip_on_launch = "true"
    tags = {
        Name = "public_subnet"
    }
}
#private subnet
resource "aws_private_subnet" "private_subnet" {
    vpc_id = "aws_vpc.my_vpc"
    availability_zone "us-east-a"
    map_private_ip_on_launch = "true"
    tags = {
        Name = "private_subnet"
    }
}
#route table assosiation
resource "aws_route_table" "public.rt" {
    vpc_id = "aws_vpc.my_vpc"
    tags = {
        Name = "public.rt"
    }
}
resource "aws_route" "default.rt" {
    route_table_id = "aws_route_table.public.rt"
    destination_cidr_block = "0.0.0.0"
    gateway_id = "aws_internet_gateway.my_igw"
}
resource "aws_route_table_association" "public.assoc" {
    subnet_id = "aws_subnet.public_subnet"
     route_table_id = "aws_route_table.public.rt"
}