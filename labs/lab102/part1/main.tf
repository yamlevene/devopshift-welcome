provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

variable "dummy" {
  default = ""
}

resource "null_resource" "check_public_ip" {
  provisioner "local-exec" {
    command = <<EOT
      if [ -z "${var.dummy}" ]; then
        echo "ERROR: Dummy variable is empty." >&2
        exit 1
      fi
    EOT
  }
}