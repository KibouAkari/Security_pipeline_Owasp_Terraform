variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default     = "b9eb2065-47fa-47ff-8e7b-e4dc39a2103f"
}
variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default     = "4e86a400-8622-4b45-bfb2-565ddc9d1048"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "switzerlandnorth"
  
}