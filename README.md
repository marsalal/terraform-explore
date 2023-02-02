# README #

**Hackathon project for 2020-Q4**

### What is this repository for? ###

* Create a HaProxy to redirect traffic to all internal tools such AWX, Concourse, Grafana, artifactory, traefik, etc. 
* A terraform module to provide load balancers in Azure
* Version: 1.0

### How do I get set up? ###

* Install terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
* Install Azure CLI (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* VS Code or your regular IDE with terraform extensions
* Open a terminal and run in your project's path:
```sh
$ terraform init
$ terraform apply -var 'azure_subscription_id=AZURE_SUBSCRIPTION_ID' -auto-approve
```

### Authors ###

* Marco Vargas
* Marco Salazar
* David Contreras