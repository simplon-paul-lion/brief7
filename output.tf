output "gitlab_pub_ip" {
  description = "adresse de l'ip public duserveur Gitlab"
  value       = azurerm_public_ip.ip-infra.ip_address
}

output "adresse_bastion"{
  description = "ip public du bastion"
  value = azurerm_public_ip.adresse_bastion.ip_address
}