module "my_hosted_zone" {
  source = "../"

  name = "example.com"

  dnssec = {
    enabled = true
  }

  associated_vpcs = [
    {
      vpc_id     = "vpc-123123"
      vpc_region = "us-east-1"
    }
  ]

  records = [
    {
      name = "something.example.com"
      type = "A"
      alias = {
        name    = "my-alb.ec2.amazonaws.com"
        zone_id = "SFGZXGZSGZSREFSEF"
      }
    }
  ]
}
