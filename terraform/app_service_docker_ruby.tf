resource "azurerm_app_service" "ruby" {
  name                = "${var.prefix}-${var.name}-docker-ruby-${var.environment}-app"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  app_service_plan_id = "${azurerm_app_service_plan.default.id}"
  tags                = "${var.tags}"

  identity = {
    type = "SystemAssigned"
  }

  site_config = {
    always_on        = true
    linux_fx_version = "DOCKER|nginx/hello"
  }
}
