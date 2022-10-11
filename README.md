# terraform-aws-route53-hosted-zone
A terraform module for an AWS Route53 hosted zone, with associated records, VPC attachments, and DNSSEC configurations

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.6 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route53_hosted_zone_dnssec.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.dnssec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_vpc_association_authorization.auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_vpc_association_authorization) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_vpcs"></a> [associated\_vpcs](#input\_associated\_vpcs) | VPCs to associate with this hosted zone | <pre>list(object({<br>    vpc_id     = string<br>    vpc_region = string<br>  }))</pre> | `[]` | no |
| <a name="input_authorized_vpc_associations"></a> [authorized\_vpc\_associations](#input\_authorized\_vpc\_associations) | VPCs from other AWS accounts that are allowed to associate with this hosted zone | <pre>list(object({<br>    vpc_id     = string<br>    vpc_region = string<br>  }))</pre> | `[]` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | A comment to leave for the hosted zone | `string` | `"Managed By Terraform"` | no |
| <a name="input_delegation_set_id"></a> [delegation\_set\_id](#input\_delegation\_set\_id) | A delegation set whose NS records you want to assign to the hosted zone | `string` | `null` | no |
| <a name="input_dnssec"></a> [dnssec](#input\_dnssec) | Configuration to enable DNSSEC for this hosted zone. If a KMS key is provided, it will be used. Otherwise, one will be created | <pre>object({<br>    enabled        = bool<br>    kms_key        = optional(string)<br>    signing_status = optional(string)<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "kms_key": null,<br>  "signing_status": null<br>}</pre> | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether or not to forcibly delete all records in the zone when the zone is deleted | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the hosted zone. Required if not using var.use\_zone | `string` | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | DNS records to create within the hosted zone | <pre>list(object({<br>    name            = string<br>    type            = string<br>    ttl             = optional(number)<br>    records         = optional(list(string))<br>    set_identifier  = optional(string)<br>    health_check_id = optional(string)<br>    alias = optional(object({<br>      name                   = string<br>      zone_id                = string<br>      evaluate_target_health = optional(bool)<br>    }))<br>    failover_routing_policy = optional(object({<br>      type = string<br>    }))<br>    geolocation_routing_policy = optional(object({<br>      continent   = string<br>      country     = string<br>      subdivision = optional(string)<br>    }))<br>    latency_routing_policy = optional(object({<br>      region = string<br>    }))<br>    weighted_routing_policy = optional(object({<br>      weight = number<br>    }))<br>    multivalue_answer_routing_policy = optional(bool)<br>    allow_overwrite                  = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the hosted zone | `map(string)` | `{}` | no |
| <a name="input_use_zone"></a> [use\_zone](#input\_use\_zone) | Manage records within an existing hosted zone instead of creating a new one | <pre>object({<br>    name    = optional(string)<br>    id      = optional(string)<br>    private = optional(bool)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_associated_vpcs"></a> [associated\_vpcs](#output\_associated\_vpcs) | The provided value for var.associated\_vpcs |
| <a name="output_authorized_vpc_associations"></a> [authorized\_vpc\_associations](#output\_authorized\_vpc\_associations) | The value provided for var.authorized\_vpc\_associations |
| <a name="output_comment"></a> [comment](#output\_comment) | The provided value for var.comment |
| <a name="output_delegation_set_id"></a> [delegation\_set\_id](#output\_delegation\_set\_id) | The provided value for var.delegation\_set\_id |
| <a name="output_dnssec"></a> [dnssec](#output\_dnssec) | The dnssec object created by this module, if enabled |
| <a name="output_dnssec_key_signing_key"></a> [dnssec\_key\_signing\_key](#output\_dnssec\_key\_signing\_key) | If enabled, the key signing key for dnssec for this hosted zone |
| <a name="output_dnssec_kms_alias"></a> [dnssec\_kms\_alias](#output\_dnssec\_kms\_alias) | The alias for the key created to implement dnssec for this hosted zone, if a key was not provided |
| <a name="output_dnssec_kms_key"></a> [dnssec\_kms\_key](#output\_dnssec\_kms\_key) | The key created to implement dnssec for this hosted zone, if one was not provided |
| <a name="output_force_destroy"></a> [force\_destroy](#output\_force\_destroy) | The provided value for var.force\_destroy |
| <a name="output_name"></a> [name](#output\_name) | The provided value for var.name |
| <a name="output_records"></a> [records](#output\_records) | Records created in this hosted zone |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags assigned to the hosted zone |
| <a name="output_zone"></a> [zone](#output\_zone) | The hosted zone object created by the module |
<!-- END_TF_DOCS -->