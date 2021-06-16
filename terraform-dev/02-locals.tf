locals {
  prefix = "${var.project_name}-v${var.infrastructure_version}-${var.stage}"
}

//locals {
//  master_ssh_key_name = "${local.prefix}-master-key"
//  public_ssh_files_list = sort(fileset(path.module, "keys/*.pub"))
//}
