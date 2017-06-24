#!/bin/bash

prerequisites() {
  local wget_cmd=`which wget`

  if [ -z "$wget_cmd" ]; then
    error "wget is required. Please install (yum install wget or apt-get install) and re-run this script. "
    exit 1
  fi
}

install_terraform() {
  wget https://releases.hashicorp.com/terraform/0.9.4/terraform_0.9.4_linux_386.zip
  unzip terraform_0.9.4_linux_386.zip -d terraform
  echo '
  # Terraform Path.
  export PATH=~/terraform/:$PATH
  ' >>~/.bashrc

  source ~/.bashrc
}

main () {

  prerequisites
  install_terraform

}

[[ "$0" == "$BASH_SOURCE" ]] && main
