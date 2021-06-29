**Execute terraform from this directory**


* Edit the `init.sh` file, setting the S3 bucket and key to suit your environment
* Ensure your AWS credentials are accessible to terraform
* Ensure the S3 bucket is accessible with your AWS credentials

Initialize the Terraform env
`./init.sh`

Dry run of Terraform
`terraform plan ../../`

Real run of Terraform
`terraform apply ../../`
