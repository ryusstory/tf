terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "rucas"
  region  = "ap-northeast-2"
}

data "aws_iam_user" "ryusstory" {
  user_name = "ryusstory"
}

output "who" {
  value = data.aws_iam_user.ryusstory.user_name
}
