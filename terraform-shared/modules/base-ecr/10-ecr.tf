resource "aws_ecr_repository" "base" {
  name                 = "${var.prefix}-${var.name}"
  image_tag_mutability = "MUTABLE"
}
