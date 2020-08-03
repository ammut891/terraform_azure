provider "azurerm" {
  version         = "=2.20.0"
  subscription_id = "4963482b-e823-42da-b47b-3705574c4497"
  client_id       = "d7f48778-8b03-4c8d-b0c5-0f396fe23b1e"
  client_secret   = "Dy~Wj~_rAYXf2.khD07q9O~486iQr9EGg~"
  tenant_id       = "74c1b636-2ecf-4527-8ccc-3175b3f71c7b"
  features {}
}

resource "azurerm_resource_group" "slotDemo" {
  name     = "terraform_webrg1"
  location = "east us"
}

resource "random_id" "randomId" {
  keepers = {
    resource_group = azurerm_resource_group.slotDemo.name
  }

  byte_length = 8
}

resource "azurerm_app_service_plan" "slotDemo" {
  name                = "slotAppServicePlan${random_id.randomId.hex}"
  location            = azurerm_resource_group.slotDemo.location
  resource_group_name = azurerm_resource_group.slotDemo.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "slotDemo" {
  name                = "appservice${random_id.randomId.hex}"
  location            = azurerm_resource_group.slotDemo.location
  resource_group_name = azurerm_resource_group.slotDemo.name
  app_service_plan_id = azurerm_app_service_plan.slotDemo.id
}
