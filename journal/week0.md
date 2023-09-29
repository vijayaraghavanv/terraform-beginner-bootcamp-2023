# Terraform Beginner Bootcamp 2023 - week0

## Table of Content
- [Semantic Versioning :mage:](#semantic-versioning--mage-)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distributions](#considerations-for-linux-distributions)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang](#shebang)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
  * [Github Lifecycle (Before, init, command)](#github-lifecycle--before--init--command-)
  * [Working Env Vars](#working-env-vars)
    + [env command](#env-command)
    + [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    + [Printing Vars](#printing-vars)
    + [Scoping of Env vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [AWS CLI Installation](#aws-cli-installation)
    
## Semantic Versioning :mage:

This project is going utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
Terraform CLI Installation instructions have changed due to gpg keyring changes. To correct the same referred the instructions via Terraform documentation and changed the scripting for install
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distributions

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to 
distribution needs.

[How to check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were considerable amount more code.Decided to create bash script to install the terraform CLI

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep Gitpod task file([.gitpod.yml](.gitpod.yml)) tidy
- Easier to debug and execute manually terraform cli install
- Better portability for other projects to install terraform cli

#### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script
e.g. `#!/usr/bin/env bash`

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Linux Permissions Considerations

In order to make our bash script executable need to change linux permissions

```sh
chmod u+x ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle(Before, init, command)

We need to be careful when using the init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

#### env command

We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`


#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env vars

when you open new bash terminal in VSCode, it will not aware env var set in another window

If you want to env vars to persist across all future bash terminals that are open you need to set
env vars in bash profile eg. `.bash profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod secrets storage

```
gp env HELLO='world'
```

All future workspace launched will set the env vars for all bash terminals opened in those workspaces.

You can also set en vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the
bash script [`./bin/install_aws_cli`](./bin/install_aws)

[Getting started install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

we can check if our AWS credentials is configured correctly by running the following
AWS-CLI-Command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AXDAAL2OJFBFLV6CAASZB",
    "Account": "123456789",
    "Arn": "arn:aws:iam::12345678:user/vijayaraghavanv"
}

We'll need to generate AWS CLI credits from IAM user inorder to the user AWS CLI.

### Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from Terraform registry which is located at
[registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the 
terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be execute by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`
This will also destroy resources

We can use auto approve flag to skip the approve prompt
`terraform apply --auto-approve`

#### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules
that should be used with this project.

The Terraform Lock file **should be committed** to your version control system (vcs) eg. Github

#### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be committed** to your VCS

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure

`.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with terraform cloud login and gitpod workspace
   
   when attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VsCode in browser.
   
   The workaround is manually generate a token in Terraform Cloud
   
   
  ```
  https://app.terraform.io/app/settings/tokens?source=terraform-login 
   ```
   
   Then create and open the file manually here:
   
   ```sh
   touch /home/gitpod/.terraform.d/credentials.trfc.json
   open /home/gitpod/.terraform.d/credentials.trfc.json
   ```
   
   provide the following code (replace your token in the file)
   
   ```json
   {
   "credentials": {
  "app.terraform.io" :{
   "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
   }
   }
   }
   ```

   Automated this workaround with following bash script [bin/generate_trfc_credentials](bin/generate_trfc_credentials)
