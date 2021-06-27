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

### RDS POSTGRES DB
SECRET_base_db_username = "starta"
SECRET_base_db_password  = "N491Ag2hAqj5umYcnQnM887K7mGO5WMR"

base_db_storage_size = 20
base_db_engine_version  = "12.6"
base_db_instance = "db.t3.micro"
base_db_maintenance_window = "Mon:00:00-Mon:03:00"
base_db_backup_window = "23:27-23:57"
base_db_backup_retention_period = "7"
