variable "location" {
  description = "The location/region in which to create the resources."
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "portfolio-resources"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "portfolio-virtual-net"
}

variable "vnet_address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "portfolio-subnet"
}

variable "subnet_prefixes" {
  description = "The address prefixes for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "nsg_name" {
  description = "The name of the network security group."
  type        = string
  default     = "portfolio-network-security-group"
}

variable "security_rule_name" {
  description = "The name of the security rule."
  type        = string
  default     = "HTTP-inbound-rule"
}

variable "service_plan_name" {
  description = "The name of the app service plan."
  type        = string
  default     = "portfolio-service-plan"
}

variable "app_service_name" {
  description = "The name of the app service."
  type        = string
  default     = "portfolioreactappbysander"
}

variable "service_plan_sku" {
  description = "The SKU of the app service plan."
  type        = string
  default     = "B1"
}

variable "app_settings" {
  description = "The environement variables to pass to the webapp"
  type        = any
  default     = {}
}

variable "github_repo_url" {
  description = "The repository that host the react app name"
  type        = string
}

variable "gihutb_token" {
  description = "Github personal access token"
  type        = string
}