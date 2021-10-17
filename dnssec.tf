resource "aws_kms_key" "dnssec" {
  count = var.dnssec.enabled && var.dnssec.kms_key == null ? 1 : 0

  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = 7
  key_usage                = "SIGN_VERIFY"
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "kms:DescribeKey",
          "kms:GetPublicKey",
          "kms:Sign",
        ],
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Sid      = "Allow Route 53 DNSSEC Service",
        Resource = "*"
      },
      {
        Action = "kms:CreateGrant",
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Sid      = "Allow Route 53 DNSSEC Service to CreateGrant",
        Resource = "*"
        Condition = {
          Bool = {
            "kms:GrantIsForAWSResource" = "true"
          }
        }
      },
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Resource = "*"
        Sid      = "IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}

resource "aws_kms_alias" "dnssec" {
  count = var.dnssec.enabled && var.dnssec.kms_key == null ? 1 : 0

  name          = replace("alias/dnssec-${var.name}", ".", "-")
  target_key_id = aws_kms_key.dnssec.0.arn
}

resource "aws_route53_key_signing_key" "dnssec" {
  count = var.dnssec.enabled ? 1 : 0

  hosted_zone_id             = aws_route53_zone.zone.id
  key_management_service_arn = var.dnssec.kms_key != null ? var.dnssec.kms_key : aws_kms_key.dnssec.0.arn
  name                       = var.name
}

resource "aws_route53_hosted_zone_dnssec" "dnssec" {
  count = var.dnssec.enabled ? 1 : 0

  hosted_zone_id = aws_route53_zone.zone.id
  signing_status = var.dnssec.signing_status
}
