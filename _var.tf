variable "authorized_vpc_associations" {
  description = "VPCs from other AWS accounts that are allowed to associate with this hosted zone"
  type = list(object({
    vpc_id     = string
    vpc_region = string
  }))
  default = []
}

variable "associated_vpcs" {
  description = "VPCs to associate with this hosted zone"
  type = list(object({
    vpc_id     = string
    vpc_region = string
  }))
  default = []
}

variable "comment" {
  description = "A comment to leave for the hosted zone"
  type        = string
  default     = "Managed By Terraform"
}

variable "delegation_set_id" {
  description = "A delegation set whose NS records you want to assign to the hosted zone"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Whether or not to forcibly delete all records in the zone when the zone is deleted"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the hosted zone"
  type        = string
}

variable "records" {
  description = "DNS records to create within the hosted zone"
  type = list(object({
    name            = string
    type            = string
    ttl             = optional(number)
    records         = optional(list(string))
    set_identifier  = optional(string)
    health_check_id = optional(string)
    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = optional(bool)
    }))
    failover_routing_policy = optional(object({
      type = string
    }))
    geolocation_routing_policy = optional(object({
      continent   = string
      country     = string
      subdivision = optional(string)
    }))
    latency_routing_policy = optional(object({
      region = string
    }))
    weighted_routing_policy = optional(object({
      weight = number
    }))
    multivalue_answer_routing_policy = optional(bool)
    allow_overwrite                  = optional(bool)
  }))
  default = []
}

variable "tags" {
  description = "Tags to assign to the hosted zone"
  type        = map(string)
  default     = {}
}
