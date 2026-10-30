
output "subnet_id" {
  description = "ID til subnettet."
  value       = azurerm_subnet.this.id
}

output "subnet_name" {
  description = "Navnet på subnettet."
  value       = azurerm_subnet.this.name
}

output "vnet_id" {
  description = "ID til det virtuelle nettverket."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Navnet på det virtuelle nettverket."
  value       = azurerm_virtual_network.this.name
}

# NY I network-v1.1.0.
output "data_subnet_id" {
  description = "ID til data-subnettet."
  value       = azurerm_subnet.data.id
}