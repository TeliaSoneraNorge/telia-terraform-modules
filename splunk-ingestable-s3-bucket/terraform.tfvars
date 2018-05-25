terragrunt = {
  terraform {
    source = "git::git@github.com:TeliaSoneraNorge/telia-terraform-modules.git//empty"
  }
  include = {
    path = "${find_in_parent_folders()}"
  }
 }
