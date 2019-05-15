provider "azurerm" {
  version = "=1.20.0"
}

data "azurerm_client_config" "current" {}

data "azurerm_builtin_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_resource_group" "default" {
  name     = "${var.name}-${var.environment}-rg"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_application_insights" "default" {
  name                = "${var.name}-ai"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  application_type    = "Web"

  tags = "${var.tags}"
}
