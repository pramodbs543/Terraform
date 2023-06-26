locals {
  public_subnets = {

    "pub_subnet_AZ1" = "10.0.0.0/24"
    "pub_subnet_AZ2" = "10.0.1.0/24"
  }

  private_subnets_cidr = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24" , "10.0.5.0/24"]
  private_subnets_az=[ "pvt_subnet_AZ1", "pvt_subnet_AZ2" , "pvt_DB_subnet_AZ1", "pvt_DB_subnet_AZ2"]
  AZ=["ap-south-1a", "ap-south-1b","ap-south-1a", "ap-south-1b"]
  nat=["nat_AZ1", "nat_AZ2"]
}

