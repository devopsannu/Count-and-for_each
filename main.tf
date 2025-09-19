terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "0f48ce1f-16d2-42ba-8b4f-0bef1a58b563"
}

resource "azurerm_resource_group" "RG1" {
  count    = 3
  name     = "dev-001"                       # 1st seniro Only with count
  location = "east us"
}

resource "azurerm_resource_group" "RG2" {
  count    = 3
  name     = count.index                   # 2nd seniro with count.index 
  location = "east   us"
}

resource "azurerm_resource_group" "RG3" {
  count    = 3
  name     = "oves${count.index}"             # 3rd seniro  with string interpolation       
  location = "east us"
}

resource "azurerm_resource_group" "RG4" {
  count    = 3
  name     = var.rgname[count.index]             # 4th seniro Only with variable
  location = "east us"
}

variable "rgname" {
  default = ["Shabbir", "Oves", "Mulla"]
}

resource "azurerm_resource_group" "RG5" {
  count    = length(var.rgname)
  name     = var.rgname[count.index]              # 5th seniro  with variable and lenght
  location = "east us"
}

variable "rgname" {
  default = ["Shabbir", "Oves", "Mulla", "Gaurav"]
}

