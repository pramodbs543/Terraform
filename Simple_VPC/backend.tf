terraform {
backend "s3" {
    bucket         = "terraformbucket9049"  # Replace with your S3 bucket name
    key            = "terraform.tfstate"
    region         = "ap-south-1"  # Replace with your desired region
    dynamodb_table = "tf-backend-s3-demo"  # Replace with your DynamoDB table name
    encrypt        = true  # Optional: Enable encryption for the state file
  }

}
