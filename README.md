# Mediawiki-terraform
Automated setup for the Mediawiki using the Terraform and Ansible

### Prerequisite
Terraform and Ansible should be installed on your computer.

### Configuration changes
Edit your variables in the variables/mediawiki.tfvars accordingly
```
vim mediawiki-terraform/variables/elastic.tfvars
```

### Steps to create the Mediawiki infrastructure.
```
git clone {{ repo_url }}
cd mediawiki-terraform
terraform apply -var-file=./variables/mediawiki.tfvars
```

### Conclusion
I have used the Terraform to provision the AWS infrastructure of 1 node for mediawiki. I used the terraform template module to populate the inventory into the ansible folder. And then use the Terraform provision method to run the ansible script. 

