# Session 19: Cloud & Terraform in Action

## 1. Project Overview

This project demonstrates how to build and manage AWS cloud infrastructure using Terraform. Terraform is an Infrastructure as Code (IaC) tool that allows us to create, modify, and manage cloud resources using configuration files.

The project creates a basic AWS infrastructure consisting of a Virtual Private Cloud (VPC), a public subnet, a security group, an EC2 instance, and an S3 bucket.

The main objective is to understand how Terraform automates cloud infrastructure deployment and management.

## 2. Objectives

- Understand Terraform providers and configuration files.
- Use variables to make the configuration reusable.
- Create AWS resources using Terraform.
- Understand resource dependencies.
- Display resource information using outputs.
- Understand Terraform state management.
- Execute `terraform init`, `terraform plan`, and `terraform apply`.
- Remove infrastructure using `terraform destroy`.

## 3. Technologies Used

- **Cloud Platform:** Amazon Web Services (AWS)
- **Infrastructure as Code:** Terraform
- **Virtual Server:** Amazon EC2
- **Networking:** Amazon VPC, Subnet, Internet Gateway
- **Security:** AWS Security Groups
- **Storage:** Amazon S3
- **Operating System:** Amazon Linux
- **Web Server:** Apache HTTP Server

## 4. Project Architecture

The project uses Terraform to provision AWS resources.

The VPC provides an isolated network environment. A public subnet hosts the EC2 instance, while an Internet Gateway and route table provide internet connectivity. A security group controls inbound and outbound traffic.

An S3 bucket provides cloud storage and has versioning enabled.

The architecture can be represented as follows:

```text
                  Terraform
                      |
                      v
                AWS Provider
                      |
          +-----------+-----------+
          |                       |
          v                       v
         VPC                  S3 Bucket
          |
          +---- Internet Gateway
          |
          +---- Public Subnet
          |          |
          |          v
          |     Security Group
          |          |
          |          v
          |      EC2 Instance
          |          |
          |      Apache Web Server
          |
          +---- Route Table
```

## 5. Project Structure

```text
Session_19_Terraform_AWS_Project/
│
├── README.md
│
├── terraform/
│   ├── versions.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── data.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
│
├── docs/
│   └── architecture.md
│
└── screenshots/
```

### Description of Files

- `versions.tf`: Defines the required Terraform and AWS provider versions.
- `provider.tf`: Configures the AWS provider and deployment region.
- `variables.tf`: Defines configurable values such as the region, CIDR blocks, and EC2 instance type.
- `data.tf`: Retrieves information about available AWS Availability Zones, the Amazon Linux AMI, and the AWS account.
- `main.tf`: Defines the AWS infrastructure resources.
- `outputs.tf`: Displays useful information about the deployed infrastructure.
- `terraform.tfvars.example`: Provides example values for Terraform variables.
- `docs/architecture.md`: Contains the architecture diagram.
- `screenshots/`: Stores screenshots captured during project execution.

## 6. AWS Resources Created

The project provisions the following resources:

1. **VPC:** Creates an isolated virtual network.
2. **Internet Gateway:** Enables internet connectivity for the public subnet.
3. **Public Subnet:** Hosts the EC2 instance.
4. **Route Table:** Directs internet-bound traffic through the Internet Gateway.
5. **Security Group:** Controls network traffic to and from the EC2 instance.
6. **EC2 Instance:** Runs an Amazon Linux server with Apache installed.
7. **S3 Bucket:** Provides cloud storage with versioning enabled and public access blocked.

## 7. Prerequisites

Before starting, ensure that the following are available:

- An AWS account.
- Terraform installed on the system.
- AWS CLI installed and configured.
- An IAM identity with the required permissions to create and manage the resources.
- A terminal or Visual Studio Code terminal.

Verify the installations:

```bash
terraform version
aws --version
aws sts get-caller-identity
```

Configure AWS credentials using:

```bash
aws configure
```

Never include AWS access keys or secret credentials in the project files.

## 8. Implementation Steps

### Step 1: Initialize Terraform

Navigate to the Terraform directory:

```bash
cd terraform
```

Initialize the working directory:

```bash
terraform init
```

This downloads the required provider and prepares Terraform to work with AWS.

### Step 2: Format and Validate

Format the configuration files:

```bash
terraform fmt
```

Validate the configuration:

```bash
terraform validate
```

Validation helps identify configuration and syntax errors before deployment.

### Step 3: Review the Execution Plan

Run:

```bash
terraform plan
```

Terraform compares the configuration with the current infrastructure state and displays the changes it intends to make.

Review the plan before proceeding.

### Step 4: Deploy the Infrastructure

Execute:

```bash
terraform apply
```

Review the proposed changes and enter `yes` when prompted.

Terraform then creates the configured AWS resources.

### Step 5: View Outputs

After successful deployment, execute:

```bash
terraform output
```

The outputs include the VPC ID, subnet ID, security group ID, EC2 instance ID, public IP address, web URL, and S3 bucket name.

To retrieve the web server URL directly:

```bash
terraform output -raw web_url
```

Open the URL in a browser to view the sample web page hosted on the EC2 instance. The page may take a short time to become available while the server initializes.

## 9. Terraform State Management

Terraform maintains a state file that records the resources managed by the configuration.

For this project, Terraform uses local state by default.

List the tracked resources:

```bash
terraform state list
```

Inspect a particular resource:

```bash
terraform state show aws_vpc.main
```

The state file helps Terraform determine which resources already exist and what changes are necessary.

The state file can contain sensitive infrastructure information. It should not be committed to a public repository.

## 10. Resource Dependencies

Terraform automatically identifies dependencies when one resource references another.

For example, the subnet references the VPC ID, so Terraform creates the VPC before creating the subnet.

The EC2 instance references the subnet and security group. An explicit `depends_on` declaration is also included to demonstrate how Terraform can enforce an additional dependency on the route table association.

This dependency handling ensures that resources are created in an appropriate order.

## 11. Destroying the Infrastructure

After testing, remove the resources created by the project:

```bash
terraform destroy
```

Review the proposed deletions and enter `yes` when prompted.

Terraform removes the managed infrastructure, helping prevent unnecessary AWS charges.

Always verify the final destruction result and check the AWS console for any resources that remain.

## 12. Screenshots Required

Capture genuine screenshots from your own terminal and AWS account for the submission.

Recommended screenshots:

1. Terraform initialization using `terraform init`.
2. Successful configuration validation using `terraform validate`.
3. Resource creation plan using `terraform plan`.
4. Successful deployment using `terraform apply`.
5. Terraform outputs.
6. VPC and subnet in the AWS console.
7. EC2 instance in the AWS console.
8. Sample web page running in a browser.
9. S3 bucket in the AWS console.
10. Terraform state listing.
11. Successful resource destruction using `terraform destroy`.

Save the screenshots in the `screenshots/` folder.

## 13. Security and Cost Considerations

AWS resources may incur charges depending on the selected region, resource usage, and account configuration.

The SSH ingress rule should be restricted to your own public IP address rather than left open to the entire internet. The S3 bucket blocks public access.

After completing the experiment, run `terraform destroy` and verify that the resources have been removed.

## 14. Expected Outcome

After completing the project, the user should be able to:

- Configure Terraform to work with AWS.
- Define infrastructure using Terraform resources.
- Manage configuration through variables and outputs.
- Understand implicit and explicit resource dependencies.
- Deploy and inspect AWS infrastructure.
- Understand Terraform state management.
- Plan, apply, and destroy infrastructure using Terraform commands.

## 15. Conclusion

This project demonstrates the practical use of Terraform to automate AWS infrastructure provisioning. It combines networking, compute, storage, and security resources in a single configuration.

By completing the initialization, validation, planning, deployment, state inspection, and destruction steps, the project provides a basic understanding of the Infrastructure as Code workflow and how Terraform simplifies cloud infrastructure management.