AWS Certified Solutions Architect — Complete Study Guide (From Scratch → High Level)

Audience & goal

- Audience: Engineers transitioning to AWS architecture from Linux/DevOps backgrounds.
- Goal: Prepare for AWS Certified Solutions Architect — Associate (SAA-C03) starting from basics, gain practical experience with key services, pass the exam, and build portfolio projects.

Assumptions

- You have 10 years of IT experience (6 years Linux, 4 years DevOps).
- Default study commitment assumed: 10 hours/week. If you can commit more or less, I will rework the timeline.
- This guide targets the Associate level (SAA-C03). If you prefer to aim for Professional, tell me and I will extend the plan.

Official exam domains (check AWS for latest blueprint)

- Domain: Design secure architectures
- Domain: Design resilient architectures
- Domain: Design high-performing architectures
- Domain: Design cost-optimized architectures
- Domain: Design operationally excellent architectures

(These domain titles are from AWS's exam blueprint — confirm weights and latest names on the official exam guide page.)

Study roadmap overview (8-week plan, 10 hrs/week)

- Week 0 (prep): Create & secure AWS account, install CLI/SDKs, set up a budget and billing alerts.
- Week 1: IAM & Security fundamentals — identities, policies, roles, KMS, CloudTrail
- Week 2: VPC & Networking — VPC design, subnets, routing, IGW, NAT, security groups, NACLs, Route 53
- Week 3: Compute & Containers — EC2, AMIs, Auto Scaling, ELB; intro to ECS/EKS and Fargate
- Week 4: Storage & Databases — S3, EBS, EFS, RDS (backup, Multi-AZ), DynamoDB
- Week 5: Serverless & Integration — Lambda, API Gateway, Step Functions, SQS, SNS
- Week 6: Observability, Monitoring & Operations — CloudWatch, CloudTrail, X-Ray, Systems Manager
- Week 7: IaC, Deployments & CI/CD — CloudFormation/CDK, Terraform basics, CodePipeline, GitHub Actions
- Week 8: Exam prep & mocks — whitepapers, well-architected review, timed mock exams, remediation

Detailed week-by-week plan (tasks & labs)

Week 0 — Account & tooling (3–5 hours hands-on)
- Create or reuse an AWS account. Enable billing alerts and set a monthly budget.
- Protect the root account with MFA.
- Create an Admin IAM user for daily use; enable MFA for that user.
- Install AWS CLI v2 and configure a named profile.
- Optional: Install AWS CDK, Terraform, Docker.

Quick CLI commands (PowerShell examples)

```powershell
# Configure AWS CLI profile
aws configure --profile my-saa

# Verify currently available regions
aws ec2 describe-regions --profile my-saa

# List S3 buckets
aws s3 ls --profile my-saa
```

Lab 0 checklist (safe test account)
- Create IAM user + admin policy (only for initial learning), enable MFA.
- Create a budget alert via AWS Budgets.
- Create a central logging S3 bucket and enable versioning (used in later labs).

Week 1 — IAM & Security (10 hrs)
- Read: IAM best practices, principle of least privilege, IAM Roles, STS, permission boundaries.
- Hands-on labs:
  - Create IAM users, groups, roles, and policies. Test cross-account role assumption with two playground accounts or use Organizations.
  - Configure an S3 bucket with SSE-KMS and bucket policies; set up an S3 lifecycle rule.
  - Enable CloudTrail and route logs to the central S3 bucket. Create CloudWatch log group and subscription filters.
- Key exam topics: IAM policy evaluation, resource policies, KMS key usage, CloudTrail and event history.

Week 2 — VPC & Networking (10–12 hrs)
- Read: VPC fundamentals, subnetting, routing, NAT vs IGW, security groups vs NACLs, VPC peering, Transit Gateway basics.
- Hands-on labs:
  - Build a VPC with 2 public and 2 private subnets across AZs, add route tables, IGW, NAT Gateway.
  - Deploy a bastion host (or use Session Manager) and verify private EC2 access.
  - Configure a VPC endpoint for S3 and test private S3 access.
- Key exam topics: design for high availability, private networking best practices, DNS (Route 53) routing policies.

Week 3 — Compute & Load Balancing (10 hrs)
- Study EC2: instance types, AMIs, EBS lifecycle, placement groups, and Auto Scaling groups (ASG).
- Load balancers: ALB vs NLB vs CLB; path-based routing and target groups.
- Hands-on labs:
  - Launch EC2 in private subnets using user-data, create an AMI from a configured instance.
  - Configure an ALB in public subnets, register ASG, test scaling policies.
  - Intro lab: container run with ECS Fargate and push an image to ECR.
- Key exam topics: capacity planning, ASG scaling triggers, health checks.

Week 4 — Storage & Databases (10 hrs)
- Study: S3 features (versioning, lifecycle, replication), EBS types, EFS, and backup strategies.
- RDS: engines, Multi-AZ, read replicas, automated backups and snapshots. DynamoDB: partition keys, GSIs, capacity modes.
- Hands-on labs:
  - Build an RDS MySQL instance in private subnet with automated backup, restore from snapshot.
  - Create DynamoDB table and test provisioning and on-demand modes.
  - Configure S3 static website hosting and CloudFront distribution.
- Key exam topics: data durability and availability, encryption at rest and in transit.

Week 5 — Serverless & Messaging (10 hrs)
- Study: Lambda architecture, cold starts, IAM roles for Lambda, API Gateway, VPC access for Lambda, Step Functions, SQS and SNS patterns.
- Hands-on labs:
  - Build a CRUD API with API Gateway + Lambda + DynamoDB; secure with IAM roles.
  - Create an SQS queue and a Lambda that processes messages; add DLQ.
- Key exam topics: serverless scaling, throttling, integration patterns.

Week 6 — Observability, Security & Operations (10 hrs)
- Study: CloudWatch metrics/logs/alarms, CloudTrail, X-Ray, AWS Config, GuardDuty, Security Hub.
- Hands-on labs:
  - Create detailed CloudWatch dashboards and alarms for application metrics.
  - Enable GuardDuty and create a sample rule in Config.
  - Use Systems Manager Session Manager to access instances without a bastion.
- Key exam topics: auditability, monitoring, automated remediation patterns.

Week 7 — IaC & CI/CD (10 hrs)
- Study: CloudFormation fundamentals, CDK overview, Terraform basics. Understand blue/green and canary deployments.
- Hands-on labs:
  - Convert your 3-tier app deployment into CloudFormation or Terraform.
  - Build a simple pipeline: push code → build image → deploy to ECS/EKS or update ASG.
- Key exam topics: idempotent deployments, rollback strategies, secure secrets in pipelines (Secrets Manager / Parameter Store).

Week 8 — Exam prep, mocks & remediation (10+ hrs)
- Read: Well-Architected Framework pillars and Security Best Practices whitepaper.
- Take 2–3 timed mock exams (80–100 questions) under exam conditions.
- Review every missed question, map it to a domain, and re-study relevant topics.
- Final checklist: cost control, tagging strategy, recovery testing, encryption, IAM review.

Hands-on projects (portfolio)
- Project A (3-tier web app): ALB → ASG EC2 (private) → RDS (Multi-AZ); S3 for static content; CloudFront optional; infra as code.
- Project B (Serverless): API Gateway → Lambda → DynamoDB, S3 file uploads, Cognito (optional) for auth.
- Project C (Analytics): Data ingest using Kinesis or S3, Glue/EMR transform, Athena/Redshift for analytics; show lifecycle and cost controls.

Practice strategy & success metric

- Aim for consistent 80%+ on official practice tests and third-party mocks (TutorialsDojo / Jon Bonso style) before scheduling.
- Keep a simple log (date, score, weak domains) in `AWS/practice-scores.md`.

Recommended resources (curated)

- Official: AWS Certified Solutions Architect - Associate exam guide (AWS Training)
- AWS Skill Builder (free modules)
- Hands-on labs: Qwiklabs, AWS Workshops
- Practice tests: Tutorials Dojo, Whizlabs, AWS sample questions
- Books/courses: A Cloud Guru, Udemy (latest SAA-C03 courses), LinuxAcademy materials
- Whitepapers: Well-Architected Framework, Security Best Practices, AWS Reliability Pillar

Exam-taking tips

- Read questions carefully — often they test non-functional requirements (cost/availability).
- Eliminate obviously wrong answers; prefer least-privilege and managed services when appropriate.
- Watch for "must meet cost objective" or "low-latency requirement" clues.
- Manage time: roughly 1.25 minutes per question for a 65–130 question format (varies). Use the review flag for uncertain ones.

Cheat-sheet / Quick checklist before booking

- IAM: root secured; admin user for learning with MFA.
- Networking: understand public/private subnet architectures.
- Databases: know Multi-AZ vs read replica differences.
- Storage: S3 durability/versions, lifecycle, Glacier; EBS vs EFS uses.
- Resilience: backups, snapshots, cross-region replication, RTO/RPO concepts.
- Cost: tagging, budgets, Savings Plans/RI basics.

Next steps I can take right now

- Customize this 8-week plan to your available hours/week (tell me hours/week).
- Create lab step-by-step guides (I can generate 1:1 walkthroughs for Lab 0 → Lab 3).
- Set up `AWS/notes` and `AWS/practice-scores.md` files in the repo and a starter CloudFormation/Terraform template.

Notes & assumptions

- This guide is a practical, hands-on pathway; it intentionally favors labs and pattern recognition over memorization.
- Verify the latest exam blueprint and domain weights in the official AWS exam guide before you schedule the test.

Good luck — tell me how many hours/week you can commit and I will output the personalized weekly calendar and start generating lab walkthroughs.

