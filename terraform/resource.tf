resource "aws_vpc" "ntire" {
    cidr_block = "192.168.0.0/22"
    tags = {
      Name = " nodejs "
      createdby =" gopi"
    }
}
resource "aws_subnet" "web" {
    cidr_block = "192.168.0.0/24"
    vpc_id = aws_vpc.ntire.id
    tags = {
      Name = "web"
    }
  
}
resource "aws_subnet" "web2" {
    cidr_block = "192.168.1.0/24"
    vpc_id = aws_vpc.ntire.id
    tags = {
      Name = "web2"
    }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ntire.id

  tags = {
    Name = "public"
  }
}
resource "aws_network_acl" "app" {
  vpc_id = aws_vpc.ntire.id
}
resource "aws_network_acl_rule" "bar" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.ntire.cidr_block
  from_port      = 22
  to_port        = 22
}
resource "aws_security_group" "all" {
  name        = "example"
  description = "example"
  vpc_id      = aws_vpc.ntire.id
  tags = {
    Name = "example"
  }
}

resource "aws_vpc_security_group_ingress_rule" "all" {
  security_group_id = aws_security_group.all.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}