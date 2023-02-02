variable "azure_subscription_id"{
    description = "(Required) The Azure Subscription Id where the resources will be created"
    type = string
}

variable "service_principal_client_id"{
    description = "(Required) The appId that was created for service principal"
    type = string
    default = "2130f1ac-f927-4a4f-a85d-9ac02c187b51"
}

variable "service_principal_client_secret"{
    description = "(Required) The password that was set for the service principal"
    type = string
    default = "6DTY8-6_UB.4YhQT-NE8CNCcJUiGZU96yV"
}

variable "service_principal_tenant_id"{
    description = "(Required) The tenant that was set for the service principal"
    type = string
    default = "26e05f1d-3a80-4284-b2d8-dc98f155801c"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where the load balancer resources will be imported."
  type        = string
  default = "terraform-resources"
}

variable "virtual_network_name" {
    type = string
    default = "vnet1"
}