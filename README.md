# Terraform Beginner Bootcamp 2023

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

### Github Lifecycle (Before, init, command)

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
