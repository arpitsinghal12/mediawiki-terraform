resource "null_resource" "mediawiki-setup" {
		
	provisioner "local-exec"{
		command = "ansible-playbook -i mediawiki/inventory mediawiki/main.yml"
	}

	triggers = {
	template = data.template_file.inventory.rendered
	cluster_instance_ids = join( ",",[
		module.ec2_cluster.id[0]
]	)
				
	}
	
	depends_on = [
		null_resource.update_inventory,
		module.ec2_cluster[0]
		]
}
