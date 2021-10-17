module "my_hosted_zone" {
  source = "../"

  name = "example.com"

  associated_vpcs = [
    {
      vpc_id     = "vpc-123123"
      vpc_region = "us-east-1"
    }
  ]

  authorized_vpc_associations = [
    {
      vpc_id     = "vpc-234234"
      vpc_region = "us-west-2"
    }
  ]
}
