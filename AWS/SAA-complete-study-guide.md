AWS Certified Solutions Architect — Complete Study Guide (SAA-C03)

Purpose

This document is a complete, from-scratch → high-level study guide to prepare for the AWS Certified Solutions Architect — Associate (SAA-C03). It combines theory, practical labs, checklists, sample IaC, practice questions, and a study calendar tailored to several weekly time commitments.

Who this is for

- Engineers with Linux/DevOps experience (like you: 6 years Linux, 4 years DevOps).
- People who prefer learning by building and want a repeatable set of labs to practice.

How to use this guide

- Follow the weekly plan for your available study time (pick a schedule below).
- Do the hands-on labs in a real AWS account (use free tier where possible, tear down resources after use).
- Keep notes in `AWS/notes/` and track mock exam scores in `AWS/notes/practice-scores.md`.

Official exam blueprint reminder

Always cross-check domain names and weights on the official AWS exam guide. The guide covers these core domains:
- Design secure architectures
- Design resilient architectures
- Design high-performing architectures
- Design cost-optimized architectures
- Design operationally excellent architectures

Study schedule options (pick one)

A. Focused (8 weeks) — ~12–15 hrs/week — recommended if you can commit significant time.
B. Balanced (10 weeks) — ~8–10 hrs/week — default recommended plan.
C. Slow & steady (12+ weeks) — ~5–7 hrs/week — if you have a full-time job and limited time.

Detailed weekly map (Balanced: 10 hrs/week)

Week 0 — Account setup & safety (3–4 hrs)
- Create AWS account or prepare sandbox account.
- Enable billing alerts and Budget with emails.
- Protect root account with MFA; create an admin IAM user and enable MFA.
- Install AWS CLI v2 and configure profile.
- Create `AWS/notes` folder in the repo and `practice-scores.md`.

Week 1 — IAM & Security (10 hrs)
- Concepts: IAM users/groups/roles, policies (identity vs resource), permission boundaries, STS, IAM best practices, KMS.
- Labs:
  - Create IAM group policies, create a cross-account role (test role assumption), create KMS key and encrypt an S3 bucket.
  - Enable CloudTrail and deliver logs to central S3 with bucket policies.

Week 2 — VPC & Networking (10–12 hrs)
- Concepts: VPC components, subnetting, route tables, IGW, NAT, security groups vs NACLs, VPC Peering, Transit Gateway, VPC endpoints.
- Labs:
  - Build a VPC with public/private subnets across 2 AZs, attach IGW and NAT Gateway.
  - Create VPC endpoint for S3 and test private access.

Week 3 — Compute & Load Balancing (10 hrs)
- Concepts: EC2 types, AMIs, EBS volume types, Auto Scaling, placement groups, ALB/NLB differences.
- Labs:
  - Launch EC2 in private subnet, create and register an AMI, deploy ALB + ASG with simple app.

Week 4 — Storage & Databases (10 hrs)
- Concepts: S3 durability & features, EBS vs EFS, RDS engines, Multi-AZ vs read replica, DynamoDB design patterns.
- Labs:
  - Launch RDS Multi-AZ and test failover (stop primary to simulate), create DynamoDB table and set GSIs.

Week 5 — Serverless & Integration (10 hrs)
- Concepts: Lambda architecture, API Gateway, Step Functions, SQS, SNS, EventBridge.
- Labs:
  - Build serverless CRUD: API Gateway → Lambda → DynamoDB; secure with IAM role.

Week 6 — Observability & Security Services (10 hrs)
- Concepts: CloudWatch metrics & logs, CloudTrail, X-Ray, GuardDuty, AWS Config, Security Hub.
- Labs:
  - Create CloudWatch dashboard and alarms; enable GuardDuty and Config in a region.

Week 7 — IaC & CI/CD (10 hrs)
- Concepts: CloudFormation, CDK, Terraform basics, CodePipeline, GitHub Actions, blue/green and canary deployments.
- Labs:
  - Convert 3-tier infra into CloudFormation or Terraform; create simple CodePipeline to deploy app image to ECS/Fargate.

Week 8 — Exam prep & mocks (10+ hrs)
- Read Well-Architected whitepapers and Security Best Practices.
- Take at least 2 full-length timed mock exams; review wrong answers and remediate.

Hands-on labs — step-by-step (selected)

Lab 0 — Account safety & CLI (Windows PowerShell)

1) Install AWS CLI v2 (Windows, winget example)

```powershell
winget install --id AWSCLI.AWSCLIV2 -e
aws --version
```

2) Configure profile

```powershell
aws configure --profile saa
# Enter your AWS Access Key ID, Secret, region (e.g., ap-south-1), and output format (json)
```

3) Create admin IAM user (console preferred for MFA)
- In the console: Create user -> Programmatic access + AWS Management Console access -> Attach AdministratorAccess (for learning only) -> Enable MFA.

Lab 1 — Build a VPC with public/private subnets (CLI + CloudFormation)

- Minimal CloudFormation template (VPC + subnets + IGW + route tables) — sample below.

Sample CloudFormation: minimal VPC

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Minimal VPC with 2 public and 2 private subnets
Resources:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.0.0.0/16
      EnableDnsSupport: true
      EnableDnsHostnames: true
      Tags:
        - Key: Name
          Value: SAA-VPC
  PublicSubnet1:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.1.0/24
      AvailabilityZone: !Select [0, !GetAZs '']
      MapPublicIpOnLaunch: true
  PublicSubnet2:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.2.0/24
      AvailabilityZone: !Select [1, !GetAZs '']
      MapPublicIpOnLaunch: true
  PrivateSubnet1:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.11.0/24
      AvailabilityZone: !Select [0, !GetAZs '']
  PrivateSubnet2:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.12.0/24
      AvailabilityZone: !Select [1, !GetAZs '']
  InternetGateway:
    Type: AWS::EC2::InternetGateway
  AttachGateway:
    Type: AWS::EC2::VPCGatewayAttachment
    Properties:
      VpcId: !Ref VPC
      InternetGatewayId: !Ref InternetGateway
Outputs:
  VpcId:
    Value: !Ref VPC
```

Deploy with AWS CLI

```powershell
aws cloudformation deploy --stack-name saa-vpc --template-file vpc.yaml --capabilities CAPABILITY_NAMED_IAM --profile saa
```

Lab 2 — Deploy a 3-tier app (summary)
- Use ALB in public subnets, ASG in private subnets, RDS in private subnet (Multi-AZ). Store static assets in S3.
- Use CloudFormation/Terraform to define parameters (AMI, instance type, DB password via Secrets Manager).

Sample Terraform snippet (provider + s3)

```hcl
provider "aws" {
  region = "ap-south-1"
  profile = "saa"
}
resource "aws_s3_bucket" "static_assets" {
  bucket = "saa-static-assets-${random_id.bucket_id.hex}"
  versioning {
    enabled = true
  }
}
```

IAM policy example (least privilege)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket",
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  ]
}
```

Practice questions (sample)

1) You have a web app that must be publicly available and store user uploads. You must keep costs low, provide 99.95% availability, and minimize management overhead. Which architecture is best?
- Answer guidance: Use S3 for uploads (static hosting if applicable) + CloudFront for global distribution + ALB + Auto-scaled compute; prefer managed services.

2) How does RDS Multi-AZ differ from Read Replica?
- Answer guidance: Multi-AZ provides synchronous replication for failover (HA), Read Replica is for read scaling (eventual consistency).

3) Which service is best for long-term archival at the lowest cost?
- Answer guidance: S3 Glacier or Glacier Deep Archive with lifecycle rules from S3.

Exam strategy & tips

- Always read to understand non-functional requirements: cost, RTO/RPO, latency, number of users.
- Prefer managed services when question asks for reduced operational overhead.
- Choose least-privilege and don't expose databases publicly.
- For performance questions, consider caching (ElastiCache, CloudFront).

Cost-safety checklist

- Enable AWS Budgets & cost alerts.
- Tag resources and use Cost Explorer to analyze.
- Tear down sandbox resources after labs; automate using scripts.

Tear-down examples (PowerShell)

```powershell
# Delete CloudFormation stack
aws cloudformation delete-stack --stack-name saa-vpc --profile saa

# Empty and delete S3 bucket (be careful)
aws s3 rm s3://my-bucket --recursive --profile saa
aws s3api delete-bucket --bucket my-bucket --profile saa
```

Resources & further reading

- AWS Official Exam Guide (SAA-C03) and sample questions
- AWS Well-Architected Framework
- AWS Whitepapers (Security, Reliability, Cost Optimization)
- Tutorials Dojo / Jon Bonso practice tests
- Qwiklabs and AWS Workshops

Next steps I will take if you want

- Generate a personalized calendar for your chosen weekly hours (tell me hours/week).
- Produce step-by-step Lab 1 and Lab 2 walkthroughs with commands and expected outputs.
- Add CloudFormation/Terraform full templates for the 3-tier app in `AWS/templates/`.

---

Appendix A — Quick CLI cheatsheet (common commands)

- List regions: aws ec2 describe-regions --profile saa
- Create S3 bucket: aws s3api create-bucket --bucket my-bucket --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1 --profile saa
- Launch EC2 (example omitted; use CloudFormation/Terraform for repeatability)

Appendix B — Short list of must-read whitepapers

- AWS Well-Architected Framework
- AWS Security Best Practices
- Architecting for the Cloud: AWS Best Practices



