resource "aws_db_subnet_group" "base" {
  name        = "${local.prefix}-db-sg"
  description = "DB subnet group"
  subnet_ids  = var.subnet_ids
}

resource "aws_db_parameter_group" "base" {
  name        = "${local.prefix}-db-param-group"
  family      = "postgres12"
}

resource "aws_db_instance" "base" {
  engine = "postgres"

  depends_on = [
    aws_db_subnet_group.base,
    aws_db_parameter_group.base
  ]

  allocated_storage      = var.db_storage_size
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance
  identifier             = local.db_identifier
  name                   = var.db_name
  username               = var.SECRET_db_username
  password               = var.SECRET_db_password
  storage_type           = "gp2"
  maintenance_window     = "Mon:00:00-Mon:03:00"
  multi_az               = false
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.base.name
  parameter_group_name   = aws_db_parameter_group.base.name
  backup_window          = var.db_backup_window
  backup_retention_period = var.db_backup_retention_period
}
