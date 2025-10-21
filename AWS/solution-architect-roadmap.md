AWS Solutions Architect Roadmap

Goal

- Prepare for AWS Certified Solutions Architect - Associate (SAA-C03) starting from scratch; optionally continue to Professional later.

Phases (high-level)

1. Foundations (1–2 weeks)
   - Cloud concepts, shared responsibility model
   - AWS global infrastructure (Regions, AZs, edge locations)
   - Basic Linux/Networking and HTTP knowledge

2. Core services (3–6 weeks)
   - Identity: IAM (users, groups, roles, policies, permission boundaries, STS)
   - Compute: EC2, AMIs, ASG, Launch Templates
   - Storage: S3 (lifecycle, versioning), EBS, EFS
   - Networking: VPC, subnets, route tables, IGW, NAT, NACLs, Security Groups, VPC peering, Transit Gateway
   - Databases: RDS (multi-AZ, read replicas), DynamoDB
   - Serverless: Lambda, API Gateway
   - Load balancing & DNS: ELB/ALB/NLB, Route 53
   - Observability: CloudWatch, CloudTrail
   - IaC: CloudFormation or Terraform basics

3. Hands-on & projects (ongoing)
   - Deploy a sample 3-tier web app (public/private subnets, LB, ASG, RDS)
   - Build serverless REST API (Lambda + API Gateway) with DynamoDB
   - Set up backup/DR (S3 lifecycle, snapshots, cross-region replication)
   - Implement CI/CD for infra and app (CodePipeline/GitHub Actions)

4. Exam prep (2–4 weeks)
   - Study exam blueprint and AWS whitepapers (Well-Architected Framework, Security Best Practices)
   - Take practice tests, review mistakes, and strengthen weak areas

5. Post-exam / Professional progression
   - Build portfolio projects, learn cost optimization, compliance, advanced networking, and prepare for Professional exam if desired.

Weekly study example (12 weeks total)

- Week 1: Foundations, create AWS account, install AWS CLI, basic IAM
- Weeks 2–5: Core services deep dive (one major area per week)
- Weeks 6–9: Hands-on projects (one project per 2 weeks)
- Weeks 10–11: Focused revision and practice exams
- Week 12: Mock exams, fix gaps, schedule certification

Practical checklist / commands to start

- Create AWS account and enable Billing Alerts (use budgets)
- Install AWS CLI and configure credentials:

```powershell
# Install AWS CLI v2 on Windows (example)
winget install --id AWSCLI.AWSCLIV2 -e
aws configure
```

- Protect root with MFA, create an admin IAM user and enable MFA
- Use IAM roles instead of long-lived credentials for labs

Resources

- Official: AWS Certified Solutions Architect - Associate exam guide and sample questions (AWS Training & Certification)
- AWS Skill Builder (free and paid courses)
- Hands-on labs: Qwiklabs, practice in your own AWS account (free tier)
- Books/courses: A Cloud Guru / Linux Academy, Coursera, Udemy (look for up-to-date SAA-C03 content)
- Whitepapers: AWS Well-Architected Framework, Security Best Practices
- Practice tests: Whizlabs, Tutorials Dojo / Jon Bonso

Safety & cost notes

- Use the free tier and always tear down resources after labs. Set a billing budget/alert before starting hands-on work.

Next steps I can take for you

- Walk through creating and securing your AWS account step-by-step
- Set up a safe hands-on lab (VPC + EC2) and walkthrough
- Start the `Define learning goals & timeline` todo in more detail (personalized timeline)

Would you like me to expand the first todo (define goals & timeline) now or set up your AWS account step-by-step?