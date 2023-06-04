This is for outputing attributes of a resource as well
#AWS S3 bucket-->bucket.tf------------------

provider "aws" {
  region     = "us-west-2"
  access_key = var.credentials["access_key"]
  secret_key = var.credentials["secret_key"]
}
resource "aws_s3_bucket" "mys3" {
  bucket = "pramod-teraform-demo-001"
}
output "mys3bucket" {
      value = aws_s3_bucket.mys3
}

#-->keys.tf---------------------
variable "credentials"{
    type = map(string)
    default = {
            access_key = ""
            secret_key = ""
    }
}



