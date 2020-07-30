# Infrastructure Hire Project 2

# Overview

At Contrast we like to play hard, work hard, and automate our SaaS environment end to end. We made this project so you can showcase your skills and give us a better idea of your individual talents!

# Setup

You will need the following:

* A fork of this repository (If you have concerns about this, let us know!)
* An AWS account (Contrast will provide a temporary one)
* Docker
* Python
* Terraform
* `kubectl`

# Overview

The overall concept of this project is to deploy a container to EKS that runs a Python script to process data from S3. We have provided the base Terraform code for a VPC and EKS cluster (along with some example IRSA code).

# Tasks

1. Create an S3 bucket in Terraform (this will be used by the container running in EKS)

1. Python script

    Write a Python script to read the `example.json` file from the S3 bucket, calculate the counts of how many `LOW`, `MEDIUM`, and `HIGH` vulnerabilities are seen PER `vendor_id`, and upload a results file to the same S3 bucket.

1. Create a Docker image for the Python script

1. Create an ECR registry for the image

1. Create the appropriate Kubernetes manifest(s) to run the Python script and exit

1. Create an IAM role to be associated with the Kubernetes resource to allow the script to access S3


## Things to keep in mind

- Treat this like a production service - think about concepts such as reliability, principle of least privilege, availability, security, etc.
- Break down the work into sizeable chunks (PR per task, commit per task, etc). Show us how you would approach this work.

# Bonus points!

Add what you feel could be missing from this project. Show us how you think about running a service in Kubernetes/AWS and what you are passionate about.

# Feedback

We love feedback. PR or create issues on this repository with feedback on what we could do better!