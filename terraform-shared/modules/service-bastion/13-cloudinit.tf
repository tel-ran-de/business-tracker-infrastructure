data "cloudinit_config" "bastion" {
  gzip = true
  base64_encode = true

  part {
    filename = "ssh_authorized_keys.cfg"
    content_type = "text/cloud-config"
    content = jsonencode(
      {
	ssh_authorized_keys = var.ssh_authorized_keys
      }
    )
  }
}
