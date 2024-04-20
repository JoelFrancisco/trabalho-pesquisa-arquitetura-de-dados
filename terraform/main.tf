terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-joel"
    key            = "trabalho-pesquisa-arquitetura-de-dados/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "terraform-state-joel-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "trabalho_pesquisa_arquitetura_de_dados" {
  bucket = "trabalho-pesquisa-arquitetura-de-dados"

  tags = {
    Name        = "Bucket do Trabalho de Pesquisa de Arquitetura de Dados"
    Environment = "Test"
  }
}

resource "aws_iam_user" "trabalho_pesquisa_arquitetura_de_dados_user" {
  name = "trabalho-pesquisa-arquitetura-de-dados-user"
}

resource "aws_iam_policy" "bucket_access" {
  name        = "BucketAccessPolicy"
  description = "A policy that grants access to a specific S3 bucket."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
        ],
        Resource = [
          "${aws_s3_bucket.trabalho_pesquisa_arquitetura_de_dados.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.trabalho_pesquisa_arquitetura_de_dados.arn
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.trabalho_pesquisa_arquitetura_de_dados_user.name
  policy_arn = aws_iam_policy.bucket_access.arn
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.trabalho_pesquisa_arquitetura_de_dados_user.name
}

