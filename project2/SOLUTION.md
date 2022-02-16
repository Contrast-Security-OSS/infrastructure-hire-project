#This is a running terraform, kubernetes and flask code. Here infrastructure is successfully built , cluster is successfully created and flask application is  
#successfully run to execute the api calls.
#
#Problems : Container image was built succesfully but it is not comptible with AWS EKS cluster. after having used docker buildx, the problems still persist in #           creating a compaitble image. Thus, when kubernetes manifest .yml code is exucuted using kubectl container reaches CrashLoopbackOFf error
#           If given more time, i will troublehoot creating this image and pushing it to AWS ECR.
#
#                                                      How to run the code :
# 1. run terraform code using terraform init, plan and apply to build VPC, EKS , s3 and networking componetns on AWS.
# 2. use docker commands to push image to ECR and transfer files into S3 bucket. CI/CD pipeline can be cfreated to automate this task.
# 3. CI/CD pipeline can also run kubernetes and terraform commands.
# 4. use kubectl commands like kubectl get pods etc to view the pods, nodes and containers
# 
# PR have been created for review which will be then pushed into master repo in Contrast github account
#      https://github.com/Contrast-Security-OSS/infrastructure-hire-project/pulls
