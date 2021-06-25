#!/bin/bash

BUCKET="YOUR_BUCKET_HERE"
KEY="YOUR_KEY_HERE"
REGION="us-east-1"

terraform init -backend-config="bucket=${BUCKET}" -backend-config="key=${KEY}" -backend-config="region=${REGION}" ../../

