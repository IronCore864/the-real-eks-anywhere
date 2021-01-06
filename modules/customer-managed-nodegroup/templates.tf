data "template_file" "userdata" {
  template = file("${path.module}/templates/userdata.sh.tpl")
  vars = {
    cluster_name        = var.cluster_name
    endpoint            = var.cluster_endpoint
    cluster_auth_base64 = var.cert_data
  }
}
