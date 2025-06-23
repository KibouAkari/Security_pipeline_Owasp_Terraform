variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default     = "subscription_id"
}
variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default     = "tenant_id"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "switzerlandnorth"

}

variable "client_id" {
  description = "Azure Client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
}
