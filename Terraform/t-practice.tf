Terraform {
   Required providers {
    aws= {
        source= "hashicorp/aws"
        version= "~>6.0"
    }
   }
}
provider "aws" {
    region= "us-east-1"
}

#VPC
resource "aws_vpc" "my-vpc" {
    cidr_block= "0.0.0.0/0"
    enable_dns_hostnames= "true"
    enable_dns support= "true"
    tags= {
        name= "my_vpc"
    }
}

#internet gateway
resource "aws_internet_gateway" "my_igw"
    vpc_id= "aws_vpc.my_vpc"

    tags= {
        name= "my_igw"
    }

#public subnets
resource "aws_public_subnet" "public_subnet" {
    vpc_id= "aws_vpc.my_vpc"
    availability_zone= "us-east-1"
    map_public_ip_on_launch= "true"
    tags={
        Name= "public_subnet"
    }
}
#private subnet
resource "aws_private_subnet" "private_subnet" {
     vpc_id= "aws_vpc.my_vpc"
    availability_zone= "us-east-1"
    map_private_ip_on_launch= "true"
    tags={
        Name= "private_subnet"
    } 
}
#route table association
resource "aws_route_table" "public.rt" {
    vpc_id= "aws_vpc.my_vpc"
    tags= {
        Name= "public.rt"
    }
}
resource "aws_route" "default.rt" {
    route_table_id= "aws_route_table.public.rt"
    destination_cidr_block= "0.0.0.0"
    gateway_id= "aws_internet_gateway.my_igw"
    tags= {
        Name= "default.rt"
    }
}
resource "aws_route_table_assoc" "public.assoc" {
    route_table_id= "aws_route_table.public.rt"
    subnet_id= "aws_public_subnet.public_subnet"
    tags= {
        Name= "public.assoc"
    }
}
==========================================
pipeline {
    agent = any
    parameters = {
        choice(name= 'ENV' , choices[dev,qa,prod],description: 'select environment to deploy')
    }

    AWS_ACCESS_KEY_ID = terraform credentials('aws_access_key_id')
    AWS_SECRET_KEY_ID = terraform credentials('aws_secret_key_id')

    stages {
        stage('check out') {
            steps {
                sh github url: https//github/repo/rettaform.git
            }
            
        }
        stage('terraform init') {
            steps {
                sh """
                cd environment/${ENV}
                terraform init backend-config/${ENV}-backend.hcl    
            }
            
        }
        stage('terraform validate') {
            steps {
                sh cd environment/${ENV} && terraform validate
            }
        }
        stage('terraform plan') {
            steps {
                sh cd environment/${ENV} && terraform plan -out=tfplan 
            }
        }
        stage('terraform apply') {
            when {
                Expression {parms.ENV != 'dev'}
            } 
            steps {
              input message 'deploy parms.ENV'
              sh cd environment/${ENV} && terraform apply -auto-approve  
            }
        }
        stage('terraform dev auto apply') {
            when {
                Expression {parms.ENV != 'dev'}
            } 
            steps {
            sh cd environment/${ENV} && terraform apply -auto-approve
            }
        }
    }
 
}