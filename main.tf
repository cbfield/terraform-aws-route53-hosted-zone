resource "aws_route53_zone" "zone" {
  comment           = var.comment
  delegation_set_id = var.delegation_set_id
  force_destroy     = var.force_destroy
  name              = var.name

  dynamic "vpc" {
    for_each = { for vpc in var.associated_vpcs : vpc.vpc_id => vpc }

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  tags = merge(var.tags, {
    "Managed By Terraform" = "true"
  })
}

resource "aws_route53_vpc_association_authorization" "auth" {
  for_each = { for auth in var.authorized_vpc_associations : auth.vpc_id => auth }

  vpc_id     = each.value.vpc_id
  vpc_region = each.value.vpc_region
  zone_id    = aws_route53_zone.zone.id
}
