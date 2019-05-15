resource "azurerm_app_service" "default" {
  name                = "${var.prefix}-${var.name}-aspnetcore-${var.environment}-app"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  app_service_plan_id = "${azurerm_app_service_plan.default.id}"
  tags                = "${var.tags}"

  identity = {
    type = "SystemAssigned"
  }

  site_config = {
    always_on        = true
    linux_fx_version = "DOTNETCORE|2.2"
    app_command_line = "dotnet demo-aspnetcore-webapp.dll --urls http://0.0.0.0:8080"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.default.fully_qualified_domain_name},1433;Database=${azurerm_sql_database.default.name};"
  }
}
