variable "resource_group_name" {
    type = string
    default = "multiplevm"
  
}

variable "location" {
    type = string
    default = "eastus"
  
}

variable "virtual_network_name" {
    type = string
    default = "multivmvnet"
  
}

variable "virutal_network_address_space" {
    type = list(string)
    default = ["10.0.0.0/16"]
  
}

variable "subnet_address_space" {
    type = list(string)
    default = ["10.0.24.0/24"]
  
}

variable "subnet_name" {
    type = string
    default = "multvmsubnet"
  
}

variable "username" {
    type = string
    default = "shivam"
  
}

variable "password" {
    type = string
    default = "Vcxz@1234567"
  
}

variable "count1" {
    type = number
    default = 2
}