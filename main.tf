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

resource "azurerm_resource_group" "RG6" {
  for_each = toset(var.rgname)
  name     = each.key                                   # 1th seniro  with toset 
  location = "east us"
}

variable "rgname" {

  default = ["Shabbir", "Mulla"]
}


resource "azurerm_resource_group" "RG7" {
  for_each = tomap(var.rgname)
  name     = each.key                                   # 2 nd seniro with tomap
  location = each.value
}

variable "rgname" {
  default = {
    "Oves"= "east us" 
    "mulla"= "west us"
    "shabbir" = "central india"
    "himanshu" = "east us"
  }
}

resource "azurerm_resource_group" "RG" {
  for_each = var.rgname
  name     = each.value.name                          # 3th   seniro  with nested map
  location = each.value.location
}

variable "rgname" {
  default = {
    Rg1 = {
      name     = "dev-rg-001"
      location = "east us"
    }

    Rg2 = {
      name     = "dev-rg-002"
      location = "west us"
    }

    Rg3 = {
      name     = "dev-rg-003"
      location = "east us"
    }
  }
}


resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnet
  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space = each.value.address_space

}

variable "vnet" {
  default = {
    vent1= {
      name = "dev-vnet-001"
      location = "east us"
      resource_group_name = "dev-rg-001"
      address_space = ["10.0.0.0/24"]
    }
     vent2= {
      name = "dev-vnet-002"
      location = "east us"
      resource_group_name = "dev-rg-001"
      address_space = ["10.10.0.0/24"]
    }

  }
  
}