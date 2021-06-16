locals {
  prefix = "${var.prefix}-${var.name}"
}

locals {
  db_identifier = "${local.prefix}-db"
  db_dns_name = "${var.name}_db"
}
