#module variables
variable "front_end_ip_name" {
    type = string
    default = "frontEnd"
}

# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  subscription_id = var.azure_subscription_id
  client_id       = var.service_principal_client_id
  client_secret   = var.service_principal_client_secret
  tenant_id       = var.service_principal_tenant_id
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "terraform" {
  name     = var.resource_group_name
  location = "West US"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vipNetwork" {
  name                = var.virtual_network_name
  resource_group_name = azurerm_resource_group.terraform.name
  location            = azurerm_resource_group.terraform.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.terraform.name
  virtual_network_name = azurerm_virtual_network.vipNetwork.name
  address_prefixes       = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = azurerm_resource_group.terraform.location
  resource_group_name = azurerm_resource_group.terraform.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_lb" "lb_hackathon" {
  name                = "TestLoadBalancer"
  location            = "West US"
  resource_group_name = azurerm_resource_group.terraform.name

  frontend_ip_configuration {
    name                 = var.front_end_ip_name
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address = "10.0.1.6"
    private_ip_address_allocation = "Static"
  }
}

resource "azurerm_lb_rule" "lb_rule_hackathon" {
  resource_group_name            = azurerm_resource_group.terraform.name
  loadbalancer_id                = azurerm_lb.lb_hackathon.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = var.front_end_ip_name
}