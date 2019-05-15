variable "location" {
  type        = "string"
  description = "Location of the azure resource group."
  default     = "WestUS2"
}

variable "environment" {
  type        = "string"
  description = "Name of the deployment environment"
  default     = "dev"
}

variable tags {
  type        = "map"
  description = "Tags to apply on all groups and resources."

  default = {
    mtc-architect = "Joey Lorich"
    deployed-with = "Terraform"
  }
}

variable "name" {
  type        = "string"
  description = "Name of the deployment."
  default     = "demo-webapp"
}

variable "prefix" {
  type        = "string"
  description = "A prefix for globally unique resources (app service hostname)"
  default     = "mtcden"
}

variable "plan_type" {
  type        = "string"
  description = "Type of App Service Plan"
  default     = "Linux"
}

variable "plan_tier" {
  type        = "string"
  description = "SKU tier of the App Service Plan"
  default     = "Basic"
}

variable "plan_sku" {
  type        = "string"
  description = "SKU of the App Service Plan"
  default     = "B1"
}
