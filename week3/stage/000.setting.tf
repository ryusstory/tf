terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "ryusstory-tf-study"
    key    = "week3/stage.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "terraform-locks-week3-files"
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
