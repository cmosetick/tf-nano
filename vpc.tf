# Define public subnet
resource "aws_vpc" "Cmosetick" {
        cidr_block = "192.168.0.0/24"
        enable_dns_support = "True"
        enable_dns_hostnames = "True"
        tags {
                Name = "Cmosetick"
        }
}
# Define Internet Gateway for vpc
resource "aws_internet_gateway" "Cmosetick-IG" {
        vpc_id = "${aws_vpc.Cmosetick.id}"
        tags {
                Name = "Cmosetick-IG"
        }
}
# Define route table for public access
resource "aws_route_table" "Public-Route" {
        vpc_id = "${aws_vpc.Cmosetick.id}"
        route = {
                cidr_block = "0.0.0.0/0"
                gateway_id = "${aws_internet_gateway.Cmosetick-IG.id}"
        }
        tags {
                Name = "Public-Route"
        }
}
# Define route table association
resource "aws_route_table_association" "Public-Route" {
        subnet_id = "${aws_subnet.Cmosetick-Public.id}"
        route_table_id = "${aws_route_table.Public-Route.id}"
}
# Public subnet
resource "aws_subnet" "Cmosetick-Public" {
        vpc_id = "${aws_vpc.Cmosetick.id}"
        availability_zone = "${var.my_availability_zone}"
        cidr_block = "192.168.0.0/24"
        tags {
                Name = "Cmosetick-Public"
        }
}
# Public access security group
resource "aws_security_group" "Cmosetick-Public" {
  name = "Cmosetick-Public"
        vpc_id = "${aws_vpc.Cmosetick.id}"
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
}
        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        # Allow all outbound traffic
        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
        tags {
                Name = "Cmosetick-Public"
        }
}
