infrastructure_version = "1"

aws_region = "eu-north-1"
aws_profile = "telran"
stage = "dev"

project_name = "starta"

cidr_block = "10.0.0.0/16"

zones = [
  {
    zone           = "eu-north-1c"
    public_subnet  = "10.0.1.0/24"
    private_subnet = "10.0.2.0/24"
  },
  {
    zone           = "eu-north-1a"
    public_subnet  = "10.0.3.0/24"
    private_subnet = "10.0.4.0/24"
  }
]

base_domain_name = "dev.starta.telran-edu.de"
base_dns_zone_id = "Z02795083K0JI2YHCU2MK"
