resource "azurerm_role_assignment" "app_service_sql" {
  scope                = "${azurerm_key_vault.default.id}"
  role_definition_name = "Reader"
  principal_id         = "${azurerm_app_service.default.identity.principal_id}"
}