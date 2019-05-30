resource "azurerm_key_vault" "default" {
  name                        = "${var.prefix}-${var.name}-${substr(var.environment,0,4)}-kv"
  location                    = "${azurerm_resource_group.default.location}"
  resource_group_name         = "${azurerm_resource_group.default.name}"
  enabled_for_disk_encryption = true
  tenant_id                   = "${data.azurerm_client_config.current.tenant_id}"

  sku {
    name = "standard"
  }

  tags = "${var.tags}"
}
