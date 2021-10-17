output "authorized_vpc_associations" {
  description = "The value provided for var.authorized_vpc_associations"
  value       = var.authorized_vpc_associations
}

output "associated_vpcs" {
  description = "The provided value for var.associated_vpcs"
  value       = var.associated_vpcs
}

output "comment" {
  description = "The provided value for var.comment"
  value       = var.comment
}

output "delegation_set_id" {
  description = "The provided value for var.delegation_set_id"
  value       = var.delegation_set_id
}

output "force_destroy" {
  description = "The provided value for var.force_destroy"
  value       = var.force_destroy
}

output "name" {
  description = "The provided value for var.name"
  value       = var.name
}

output "records" {
  description = "Records created in this hosted zone"
  value       = aws_route53_record.record
}

output "tags" {
  description = "Tags assigned to the hosted zone"
  value = merge(var.tags, {
    "Managed By Terraform" = "true"
  })
}

output "zone" {
  description = "The hosted zone object itself"
  value       = aws_route53_zone.zone
}
