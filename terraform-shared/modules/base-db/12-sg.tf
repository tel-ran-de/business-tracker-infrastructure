# private
resource "aws_security_group" "db" {
  name        = "${local.prefix}-db-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = ["${aws_security_group.db_client.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.prefix}-db-sg"
  }
}

# public
resource "aws_security_group" "db_client" {
  name        = "${local.prefix}-db-client-sg"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.prefix}-db-client-sg"
  }
}
