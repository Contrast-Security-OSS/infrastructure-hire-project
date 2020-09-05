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

    Write a Python script to read the `example.json` file from the S3 bucket, calculate the counts of how many `LOW`, `MEDIUM`, and `HIGH` vulnerabilities are seen PER `vendor_id`, and upload a results file to the same S3 bucket, or return via http request.

1. Create a Docker image for the Python script

1. Create an ECR registry for the image

1. Create the appropriate Kubernetes manifest(s) to run the Python script.

1. Create an IAM role to be associated with the Kubernetes resource to allow the script to access S3

### Senior Candidates (or anyone looking to have some more fun!)
For a senior candidate we'd like to explore more into your Kubernetes knowledge. In the flask directory, there are two python apps and a requirements file, that can be used a template to create your web service. We would like you to create a simple web service (using a proxy) to return the vulnerability data via the proxy service from previously created script.

1. Update the Python script previously created to be a Flask application that returns the vulnerability data via HTTP (using `vuln.py` as the starting point)

1. Update the Docker image to run the Flask application

1. Deploy the Flask application (`vuln.py`) to Kubernetes

1. Update `proxy.py` with the appropriate endpoints for vulnerability service

1. Create a Docker image for the `proxy.py` service

1. Deploy the proxy service to Kubernetes using an ALB for ingress

1. Test that GET /vulns returns the appropriate data

#### Optional

1. Deploy a basic NGINX service and test you can get access via GET /evil endpoint
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install nginx bitnami/nginx --set service.type=ClusterIP
```

1. Utilizing a CNI or service mesh and restrict access from the proxy service to the nginx service

## Things to keep in mind

- Treat this like a production service - think about concepts such as reliability, principle of least privilege, availability, security, etc.
- Break down the work into sizeable chunks (PR per task, commit per task, etc). Show us how you would approach this work.

# Bonus points!

Add what you feel could be missing from this project. Show us how you think about running a service in Kubernetes/AWS and what you are passionate about.

# Feedback

We love feedback. PR or create issues on this repository with feedback on what we could do better!