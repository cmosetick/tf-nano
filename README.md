tf-nano
=======

## Create t2.nano instances in AWS EC2 with Terraform

_Easily substitute t2.nano for any other instance type._

**Ideal base layer for creating deployment instances with [Distelli](https://www.distelli.com/)**.

### Features
- cloud-config / cloud-init [template integration](https://www.terraform.io/docs/providers/template/r/file.html) with Terraform for [headless configuration](https://www.distelli.com/docs/agent/automated-install-of-the-distelli-agent)
of Distelli agent on your instances

- ability to bootstrap agent onto instances than are behind NAT

- instances are created in standalone, project based, VPC and subnet

- single or multi-region instance creation via terraform variables file and count

- scalable to N instances (limit is defined by your AWS account limits)

- in-project ssh key to access instances with the operator's system ssh-agent (optional)

- locked down security group: tcp/22,80,443 are the only open public facing ports

- Ubuntu 16.04, us-west-2, HVM, SSD instance by default

## Usage
- git clone https://github.com/cmosetick/tf-nano.git

- `cd tf-nano`

- change your EC2 instance type, AMI, or region as desired in `variables.tf`

- create `terraform.tfvars` file using the example file as basis.
Input your AWS API credentials in the file. Note that this file name is in `.gitignore`

- create an ssh key using the following format:  
`ssh-keygen -t rsa -b 2048 -P '' -f files/cmosetick-terraform -C 'tfnano@demo'`

- add the new key to the operator's ssh agent session:  
`ssh-add files/cmosetick-terraform ; ssh-add -l`  
If you change the name of your key, make sure you add a line to `.gitignore` with the name

- `terraform plan`
- `terraform apply`

#### Caveats
- If you select an AMI that does not have `cloud-init` package installed, your instances will be created, but you will not have an agent installed from the included cloud-config template. Most distros today include cloud-init.
