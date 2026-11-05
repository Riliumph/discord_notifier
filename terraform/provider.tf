# TerraformのProviderの設定を記述する。

# Terraformの最低バージョンなどの制約を記述
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

# AWS Providerの設定
# AWSの認証設定
# AWSのどのリージョンのAPIに接続するか
# などを記述する。
provider "aws" {
  region = var.region
  # 全リソースに強制的に付与するタグ
  default_tags {
    tags = {
      project = var.project_name
      owner   = var.owner_name
    }
  }
}

