# How many ec2 instances should we create
variable "count" {
  default = 0
}

variable "access_key" {}
variable "secret_key" {}

variable "region" {
        default = "us-west-2"
}

variable "my_availability_zone"{
        default = "us-west-2a"
}

variable "my_subnet"{
  # Unused here, but if you need to hard code your project
  # into a static subnet that never changes
  default = "subnet-b3cc3fc5"
}

variable "my_amis" {
        default = {
                us-west-2 = "ami-0eea016e" #Ubuntu 16.04 Devel, hvm:ebs-ssd, us-west-2
                #us-west-1 = " "
                #us-east-1 = " "

        }
}

variable "key_name" {
        default = "cmosetick-terraform" # key name in ssh-agent session to use to connect to host vm
}
