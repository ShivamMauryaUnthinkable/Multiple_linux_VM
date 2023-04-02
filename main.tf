provider "azurerm" {
    features {
      
    }
  
}

terraform {
  backend "azurerm" {
        resource_group_name = "tfstate"
        storage_account_name = "tfstate286"
        container_name = "multiplevms"
        key = "terraform.tfstate"    
  }
}

resource "azurerm_resource_group" "multiplevm" {
    name = var.resource_group_name
    location = var.location
  
}

resource "azurerm_virtual_network" "vent" {
    name = var.virtual_network_name
    resource_group_name = azurerm_resource_group.multiplevm.name
    location = azurerm_resource_group.multiplevm.location
    address_space = var.virutal_network_address_space
  
}

resource "azurerm_subnet" "multivmsubnet" {
    name = var.subnet_name
    resource_group_name = azurerm_resource_group.multiplevm.name
    virtual_network_name = azurerm_virtual_network.vent.name
    address_prefixes = var.subnet_address_space  
}

resource "azurerm_network_interface" "multivm_interface" {
    count = var.count1
    name = "newvm${count.index}"
    resource_group_name = azurerm_resource_group.multiplevm.name
    location = azurerm_resource_group.multiplevm.location
    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.multivmsubnet.id
      private_ip_address_allocation = "Dynamic"
    }
    
  
}

resource "azurerm_linux_virtual_machine" "name" {
    count = var.count1
    name = "linuxvm${count.index}"
    resource_group_name = azurerm_resource_group.multiplevm.name
    location = azurerm_resource_group.multiplevm.location
    size = "Standard_b1ms"
    admin_username = var.username
    network_interface_ids = [element(azurerm_network_interface.multivm_interface.*.id, count.index)]
    
    os_disk {
    name              = "myosdisk${count.index}"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202209200"
 }
  disable_password_authentication = false
  admin_password = var.password

}
