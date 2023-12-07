# Azure Resource Group
resource "azurerm_resource_group" "portfolio_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}

# Subnet
resource "azurerm_subnet" "sub" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.portfolio_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.portfolio_resource_group.name
}

# Security Rule
resource "azurerm_network_security_rule" "nsr" {
  name                        = var.security_rule_name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.portfolio_resource_group.name
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

# Network Security Group Association
resource "azurerm_subnet_network_security_group_association" "nsga" {
  subnet_id                 = azurerm_subnet.sub.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# App Service Plan
resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = azurerm_resource_group.portfolio_resource_group.name

  os_type  = "Linux" # Set the operating system to Linux
  sku_name = "B1"
}


resource "azurerm_linux_web_app" "linux" {
  name                = "${var.app_service_name}"
  resource_group_name = azurerm_resource_group.portfolio_resource_group.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.sp.id
  app_settings        = var.app_settings

  site_config {
    app_command_line = "pm2 serve /home/site/wwwroot/build --spa --no-daemon"
    application_stack {
      node_version = "16-lts"
    }
  }
}

resource "azurerm_app_service_source_control" "example" {
  app_id                 = azurerm_linux_web_app.linux.id
  repo_url               = var.github_repo_url
  branch                 = "main"
  use_manual_integration = true
  use_mercurial          = false
}

resource "azurerm_source_control_token" "example" {
  type         = "GitHub"
  token        = var.gihutb_token
  token_secret = var.gihutb_token
}

