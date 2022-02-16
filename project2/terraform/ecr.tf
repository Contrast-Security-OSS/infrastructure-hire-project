

resource "aws_ecr_repository" "proxy_image" {
  name                 = "proxy_image"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "vuln_image" {
  name                 = "vuln_image"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecrpublic_repository" "proxy_image" {
  #provider = aws.us_east_1

  repository_name = "proxy_image"

  catalog_data {
    about_text        = "Creating repository to store docker image"
    architectures     = ["x86-64"]
    #logo_image_blob   = filebase64(image1.png)
    operating_systems = ["Linux"]
    usage_text        = "to create kubernetes containers"
  }
}

resource "aws_ecrpublic_repository" "vuln_image" {
  #provider = aws.us_east_1

  repository_name = "vuln_image"

  catalog_data {
    about_text        = "Creating repository to store docker image"
    architectures     = ["x86-64"]
    #logo_image_blob   = filebase64(image2.png)
    operating_systems = ["Linux"]
    usage_text        = "to create kubernetes containers"
  }
}

/*
resource "aws_ecr_repository_policy" "vuln_image" {
  repository = aws_ecr_repository.vuln_image.name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}


resource "aws_ecr_repository_policy" "proxy_image" {
  repository = aws_ecr_repository.proxy_image.name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}
*/