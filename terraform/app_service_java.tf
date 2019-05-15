resource "azurerm_app_service" "java" {
  name                = "${var.prefix}-${var.name}-java-${var.environment}-app"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  app_service_plan_id = "${azurerm_app_service_plan.default.id}"
  tags                = "${var.tags}"

  identity = {
    type = "SystemAssigned"
  }

  site_config = {
    always_on              = true
    java_version           = "1.8"
    java_container         = "tomcat"
    java_container_version = "9.0"
  }
}
