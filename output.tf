output "gitlab_pub_ip" {
  description = "adresse de l'ip public duserveur Gitlab"
  value       = azurerm_public_ip.ip-infra.ip_address
}