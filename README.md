# Polkadot node provisioning

This repository is an example of how you can provision a production grade Polkadot node on Amazon Web Services.

In this repo three tools are used:

1. Terraform - for creating infrastructure (i.e. networks, servers, access control, etc)
2. Ansible - for configuration (i.e. installing packages and system updates, etc) of machine images that are created by Packer
3. Packer - for creating artifacts (i.e. backing machine images) to be used by Terraform

### Bake Amazon Machine Image
```
packer build template.json
```

### Generate infrastructure plan
```
terraform plan
```

### Provision infrastructure
```
terraform apply --auto-approve
```

## Destroy infrastructure (canno be undone)
```
terraform destroy
```

### Things I still need to get to:
- Finish up networking and security Terraform modules
- Testing code
- Creating a pipeline to automate infrastructure management using continuous integration
- Possibly switch Packer template from JSON to HCL
