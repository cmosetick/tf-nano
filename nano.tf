provider "aws" {
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
	region = "${var.region}"
}
resource "aws_instance" "Cmosetick-Nano" {
  ami = "${lookup (var.my_amis,var.region) }"
  instance_type = "t2.nano"
  key_name = "${var.key_name}" # ssh key required for terraform provisioner
  subnet_id = "${aws_subnet.Cmosetick-Public.id}"
	#subnet_id = "${var.my_subnet}"
  availability_zone = "${var.my_availability_zone}"
	# see variables.tf to control how many instances
  count = "${var.count}"
	#user_data = "${element(template_file.host_init.*.rendered, count.index)}"
  security_groups = ["${aws_security_group.Cmosetick-Public.id}"]
  # public ip is optional in this scenario, useful for testing s
  associate_public_ip_address = "True"
	user_data = "${file("cloud-config/install.yml")}"
		tags {
    Name = "${format("Cmosetick-Nano-%03d", count.index + 1)}"
    }
}
