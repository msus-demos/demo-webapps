resource "azurerm_app_service_plan" "default" {
  name                = "${var.name}-plan"
  location            = "${azurerm_resource_group.default.location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  kind                = "${var.plan_type}"
  tags                = "${var.tags}"
  reserved            = true

  sku {
    tier = "${var.plan_tier}"
    size = "${var.plan_sku}"
  }
}
