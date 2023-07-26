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
  #This is for windows powershell.
  # $env:AWS_ACCESS_KEY_ID = "YOUR_ACCESS_KEY"
  # $env:AWS_SECRET_ACCESS_KEY = "YOUR_SECRET_KEY"
  
  # For Linux:
  # export AWS_ACCESS_KEY_ID=Your_Access_Key 
  # export AWS_SECRET_ACCESS_KEY=Your_Secred_Access_Key 

}
