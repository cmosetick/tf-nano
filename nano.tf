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
							provisioner "file" {
							connection {
					    user = "ubuntu"
					    host = "${aws_instance.Cmosetick-Nano.public_ip}"
					    timeout = "2m"
					    key_file = "files/cmosetick-terraform"
					    }
							source = "files/doit.sh"
							destination = "/home/ubuntu/test.sh"
							}
							provisioner "file" {
							connection {
							user = "ubuntu"
							host = "${aws_instance.Cmosetick-Nano.public_ip}"
					    timeout = "2m"
					    key_file = "files/cmosetick-terraform"
							}
							source = "files/distelli.yml"
							destination = "/home/ubuntu/distelli.yml"
							}
				provisioner "remote-exec" {
        connection {
        user = "ubuntu"
        host = "${aws_instance.Cmosetick-Nano.public_ip}"
        timeout = "2m"
        key_file = "files/cmosetick-terraform"
    	}
      	script = "files/doit.sh"
    }
}
