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

variable "tags" {
  description = "Tags to assign to the hosted zone"
  type        = map(string)
  default     = {}
}
