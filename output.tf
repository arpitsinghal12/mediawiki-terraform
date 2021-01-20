output "public_ip" {
  description = "mediawiki cluster information"
  value       = module.ec2_cluster.public_ip[0]
}


