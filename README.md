tf-nano
=======

## Create t2.nano instances in AWS EC2 with Terraform

_Easily substitute t2.nano for any other instance type._

**Ideal base layer for creating large build server instances with [Distelli](https://www.distelli.com/)**.

### Features
- `distelli.yml.example` file for [headless configuration](https://www.distelli.com/docs/agent/automated-install-of-the-distelli-agent)
of Distelli agent on your instances

- instances are created in standalone VPC and subnet

- single or multi-region instance creation via terraform variables file and count

- locked down security group tcp/22,80,443 are the only open public facing ports


## Usage
- change your EC2 instance type, AMI, or region as desired
- git clone https://github.com/cmosetick/tf-nano.git
- `cd tf-nano`
- `terraform plan`
- `terraform apply`
