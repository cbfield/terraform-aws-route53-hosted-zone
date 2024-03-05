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

output "dnssec" {
  description = "The dnssec object created by this module, if enabled"
  value       = local.dnssec_enabled ? aws_route53_hosted_zone_dnssec.dnssec[0] : null
}

output "dnssec_key_signing_key" {
  description = "If enabled, the key signing key for dnssec for this hosted zone"
  value       = local.dnssec_enabled ? aws_route53_key_signing_key.dnssec[0] : null
}

output "dnssec_kms_alias" {
  description = "The alias for the key created to implement dnssec for this hosted zone, if a key was not provided"
  value       = local.dnssec_enabled && var.dnssec.kms_key == null ? aws_kms_alias.dnssec[0] : null
}

output "dnssec_kms_key" {
  description = "The key created to implement dnssec for this hosted zone, if one was not provided"
  value       = local.dnssec_enabled && var.dnssec.kms_key == null ? aws_kms_key.dnssec[0] : null
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
  description = "The hosted zone object created by the module"
  value       = local.create_zone ? one(aws_route53_zone.zone) : one(data.aws_route53_zone.zone)
}
