resource "azurerm_sql_server" "default" {
  name                         = "${var.name}-sql"
  resource_group_name          = "${azurerm_resource_group.default.name}"
  location                     = "${azurerm_resource_group.default.location}"
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "${random_string.password.result}"

  tags = "${var.tags}"
}

resource "azurerm_sql_firewall_rule" "allow_any" {
  name                = "AllowAny"
  resource_group_name = "${azurerm_resource_group.default.name}"
  server_name         = "${azurerm_sql_server.default.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "254.254.254.254"
}

resource "azurerm_sql_database" "default" {
  name                = "${var.name}"
  resource_group_name = "${azurerm_resource_group.default.name}"
  location            = "${azurerm_resource_group.default.location}"
  server_name         = "${azurerm_sql_server.default.name}"

  tags = "${var.tags}"
}

resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "/@\" "
}
