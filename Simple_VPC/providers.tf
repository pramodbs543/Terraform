terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.3.0"
    }
  }


}
provider "aws" {
  region     = var.region
  #The access and secret keys are stored as part of environment variables.
  #Using 
  # $env:AWS_ACCESS_KEY_ID = "YOUR_ACCESS_KEY"
  # $env:AWS_SECRET_ACCESS_KEY = "YOUR_SECRET_KEY"

}
