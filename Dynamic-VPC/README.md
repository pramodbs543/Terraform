This VPC was created for a three tier application deployment in AWS. 
**VPC contains 2 AZs**: ap-south-1a, ap-south-1b
**6 subnets(2 public and 4 private)**: 2 Public subnets(each in different AZ) for the web tier application, 2 private subnets for app tier(backend app), 2 private subnets for DB
**Internet Gateway**: Attached to VPC
**2 Nat Gateways(Each attached to an AZ)**: Each NAT Gateway is attached to different public subnet. These are to be used while configuring the app tier instances(Need to install some patches)
**3 Route Tables**: One public subnet routing to internet gateway, 2 private route tables, each of them atached to private subnets of app tier instances(Routing to NAT gateways)
