variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "my-demo-rg"  # Provide a default value or set it during runtime
  description = "Name of the resource group."
}

variable "kubernetes_cluster_name" {
  type        = string
  default     = "my-demo-cluster"  # Provide a default value or set it during runtime
  description = "Name of the Kubernetes cluster."
}

variable "kubernetes_cluster_dns_prefix" {
  type        = string
  default     = "mydns"  # Provide a default value or set it during runtime
  description = "DNS prefix of the Kubernetes cluster."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}
