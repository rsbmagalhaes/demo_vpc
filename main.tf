resource "ibm_is_vpc" "vpc1" {

  name = "vpc1"

  address_prefix_management = "manual"
}

resource "ibm_is_vpc_address_prefix" "addprefix1" {

  name = "addprefix1"

  zone = var.zone1

  vpc  = ibm_is_vpc.vpc1.id

  cidr = "10.84.0.0/17"

}

resource "ibm_is_subnet" "subnet1" {

  name            = "subnet1"

  vpc             = ibm_is_vpc.vpc1.id

  zone            = var.zone1

  ipv4_cidr_block = "10.84.0.0/18"

}

resource "ibm_is_vpn_gateway" "VPNGateway1" {

  name   = "vpn1"

  subnet = ibm_is_subnet.subnet1.id

}


resource "ibm_is_vpn_gateway_connection" "VPNGatewayConnection1" {

  name          = "vpnconn1"

  vpn_gateway   = ibm_is_vpn_gateway.VPNGateway1.id

  peer_address  = ibm_is_vpn_gateway.VPNGateway1.public_ip_address

  preshared_key = "VPNDemoPassword"

  local_cidrs   = [ibm_is_subnet.subnet1.ipv4_cidr_block]

  peer_cidrs    = [ibm_is_subnet.subnet1.ipv4_cidr_block]

#  ipsec_policy  = ibm_is_ipsec_policy.example.id

}



#resource "ibm_is_ssh_key" "sshkey" {

 # name       = "ssh1"
#
 # public_key = file(var.ssh_public_key)
#
#}
#
#

#resource "ibm_is_instance" "instance1" {
#
 # name    = "instance1"

#  image   = var.image
#
 # profile = var.profile
#

#
 # primary_network_interface {

  #  subnet = ibm_is_subnet.subnet1.id
#
#  }
#

#
 # vpc       = ibm_is_vpc.vpc1.id

  #zone      = var.zone1

#  keys      = [ibm_is_ssh_key.sshkey.id]
#
#}


#resource "ibm_is_security_group" "sg1" {
#
 # name = "sg1"

  #vpc  = ibm_is_vpc.vpc1.id

#}



#resource "ibm_is_security_group_network_interface_attachment" "sgnic1" {

 # security_group    = ibm_is_security_group.sg1.id

  #network_interface = ibm_is_instance.instance1.primary_network_interface[0].id

#}



#resource "ibm_is_security_group_rule" "sg1_tcp_rule" {


 # group      = ibm_is_vpc.vpc1.default_security_group

  #direction  = "inbound"

  #remote     = "0.0.0.0/0"



 # tcp {

  #  port_min = 22

   # port_max = 22

 # }

#}



#resource "ibm_is_security_group_rule" "sg1_icmp_rule" {

 # group      = ibm_is_vpc.vpc1.default_security_group

  #direction  = "inbound"

 # remote     = "0.0.0.0/0"



 # icmp {

  #  code = 0

   # type = 8

 # }

#}



#resource "ibm_is_security_group_rule" "sg1_app_tcp_rule" {

 # group      = ibm_is_vpc.vpc1.default_security_group

  #direction  = "inbound"

 # remote     = "0.0.0.0/0"



 # tcp {

  #  port_min = 80

   # port_max = 80

 # }

#}
