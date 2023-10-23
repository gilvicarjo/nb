# nb

## The Project

This repo has been created to host a business case and its resolution for a DevOps engineer position at Neobrain.

## The Tech Stack

Basically the technical stack for this project is based on the following ones:
- Kubernetes
- Azure (GCP/OVH)
- Helm
- Git
- Terraform

## Create Azure Account 

The very first step is to create an Azure account after this you will have a Subscription ID.

## Create a Git Repository

When creating the Git repository, you will need to create a SSH Key Pair

```markdown
 ssh-keygen -b 4096 -t rsa
```

After creating it, it's supposed to set the right permissions to this key
```markdown
 chmod 0400 /path/.ssh/key.pub
```

Then, add it as a default identifier
```markdown
 ssh-add /path/.ssh/key.pub
```

Next, you can validate the git SSH connection
```markdown
 ssh -T git@github.com
```


## Install Azure CLI
```markdown
brew update
brew install azure-cli
az --version
```

## Install Terraform


