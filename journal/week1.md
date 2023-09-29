# Terraform Beginner Bootcamp 2023 - week1

## Root Module Structure

Out root module structure as follows

```
  PROJECT_ROOT
  ├─ main.tf - everything else
  ├─ variables.tf - stores the structure of input variables
  ├─ providers.tf - defined required providers and their configurations
  ├─ outputs.tf - store our outputs
  ├─ terraform.tfvars - the data of variables we want to load into our terraform project
  └─ README.md - required for root modules
```
 
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
