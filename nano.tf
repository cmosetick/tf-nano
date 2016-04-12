provider "aws" {
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
	region = "${var.region}"
}
resource "aws_instance" "Cmosetick-Nano" {
          ami = "${lookup (var.my_amis,var.region) }"
                instance_type = "t2.nano"
                key_name = "${var.key_name}" # required for terraform provisioner
                subnet_id = "${aws_subnet.Cmosetick-Public.id}"
								#subnet_id = "${var.my_subnet}"
                availability_zone = "${var.my_availability_zone}"
                count = "1"
                security_groups = ["${aws_security_group.Cmosetick-Public.id}"]
                # public ip required to provision with Terraform
                associate_public_ip_address = "True"
								tags {
                        Name = "Cmosetick-Nano"
                }
								# Copy distelli.yml file to /etc/disetelli.yml on remote system
								provisioner "file" {
								source = "files/distelli.yml"
								destination = "/home/ubuntu/distelli.yml" # credentials file for distelli agent
								connection {
								user = "ubuntu"
								agent = "True" # this is to use ssh-agent session for connection
								}
							}
								provisioner "file" {
								source = "files/client"
								destination = "/home/ubuntu/client" # this is installer shell script for distelli agent
								connection {
								user = "ubuntu"
								agent = "True" # this is to use ssh-agent session for connection
								}
							}
								# Install distelli agent on remote system
								provisioner "remote-exec" {
								    inline = [
										"curl -sSL https://www.distelli.com/download/client | sh",
								    "sudo /usr/local/bin/distelli agent install -conf /home/ubuntu/distelli.yml"
								    ]
								}
}
