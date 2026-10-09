output "rg_id" {
  value = azurerm_resource_group.demo.id
}

output "resource_group_name" {
  description = "Navnet på ressursgruppen. Nyttig for å finne igjen ressursene i portalen."
  value       = azurerm_resource_group.main.name
}

output "subnet_id" {
  description = "ID-en til subnettet, hentet ut av nettverksmodulen."
  value       = module.network.subnet_id
}

output "vnet_name" {
  description = "Navnet på det virtuelle nettverket."
  value       = module.network.vnet_name
}

