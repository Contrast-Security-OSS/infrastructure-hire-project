# Infrastructure Hire Project 

# Introduction

At Contrast we like to play hard, work hard, and automate our SaaS environment end to end. We made this project so you can showcase your skills and give us a better idea of your individual talents!

# Setup

You will need the following:

* A fork of this repository (If you have concerns about this, let us know!)
* An AWS account (Contrast will provide a temporary one)
* Install Docker
* Install Python
* Install the [AWS CLI](https://aws.amazon.com/cli/) (`pip install awscli`)

# Deploying the current stack

```
aws cloudformation deploy --template-file infrastructure/infrastructure.yml --stack-name ops-hire-project --tags Name=ops-hire-project Environment=dev
```

# Tasks

- Update the infrastructure to run the container in Fargate
- Add monitoring for your service
- Add an endpoint to `app.py` to return a file from an S3 bucket

## Things to keep in mind 

- Treat this like a production service - think about concepts such as reliability, principle of least privilege, availability, security, etc.
- Break down the work into sizeable chunks (PR per task, commit per task, etc). Show us how you would approach this work.

# Bonus points!

Add what you feel could be missing from this project. Show us how you think about running a service in AWS and what you are passionate about.

# Feedback

We love feedback. PR or create issues on this repository with feedback on what we could do better!