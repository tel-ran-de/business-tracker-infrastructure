resource "aws_instance" "bastion" {
  ami = var.ami_id

  instance_type = var.instance_type
  key_name = var.aws_key_pair_name
  subnet_id = var.subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = concat(
    [aws_security_group.bastion.id],
    var.extra_security_group_ids
  )

  # iam_instance_profile = "${aws_iam_instance_profile.fubar.name}"

  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_block_device_size
  }

  tags = {
    Name = "${var.prefix}-bastion"
  }

  user_data_base64 = data.cloudinit_config.bastion.rendered

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
    host        = self.public_ip
    timeout     = 60
  }

  provisioner "remote-exec" {
    inline = [
      "df -h",
      "top -b -n 1 | head -n15"
    ]
  }
}
