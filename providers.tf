terraform {
  #  backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "TerraformBeginnerBootcamp"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
#  cloud {
#     organization = "TerraformBeginnerBootcamp"

#     workspaces {
#       name = "terra-house-1"
#     }
# }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws"{
}

#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
provider "random" {
  # Configuration options
}