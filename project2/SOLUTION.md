#This is a running terraform, kubernetes and flask code. Here infrastructure is successfully built , cluster is successfully created and flask application is  
# successfully run to execute the api calls.
#
# Problems : Container image was built succesfully but it is not comptible with AWS EKS cluster. after having used docker buildx, the problems still persist in#           creating a compaitble image. Thus, when kubernetes manifest .yml code is exucuted using kubectl container reaches CrashLoopbackOFf error
#           If given more time, i will troublehoot creating this image and pushing it to AWS ECR and then use URL to test the code and output.I also had proble#           ms to adjust my laptop to execute flask, terraform, docker commands since the OS is very old. Managing project with work was a little difficult.
#
#
#
#                                                      How to run the code :
# 1. run terraform code using terraform init, plan and apply to build VPC, EKS , s3 and networking componetns on AWS.
# 2. use docker commands to push image to ECR and transfer files into S3 bucket. CI/CD pipeline can be cfreated to automate this task.
# 3. CI/CD pipeline can also run kubernetes and terraform commands.
# 4. use kubectl commands like kubectl get pods etc to view the pods, nodes and containers
# 
# PR have been created for review which will be then pushed into master repo in Contrast github account
#      https://github.com/Contrast-Security-OSS/infrastructure-hire-project/pulls
#
#  163853439795.dkr.ecr.us-east-1.amazonaws.com/proxy_image   latest            c060c409b798   36 hours ago   955MB
#  163853439795.us-east-1.amazonaws.com/proxy_image           latest            c060c409b798   36 hours ago   955MB
#  proxy                                                      latest            c060c409b798   36 hours ago   955MB
#
#  Error in pods using kubectl get pods :
#    vuln-python-6494b7cd7f-8twv6   0/1     CrashLoopBackOff   204        17h
#    vuln-python-7ccd4c8fdb-8mn76   0/1     CrashLoopBackOff   204        16h
#
#
#  Tasks which run properly : Terraform, flask, kubectl.
#  Problems : Docker image is not built propelry and not compatible with AWS EKS. Laptop doesnt support this build so having issues using buildx.
#
#
#  Thank you for this project, I learnt small tasks which I was not doing myself at work. It was done by developers especially with docker commands.
 
#
# 
