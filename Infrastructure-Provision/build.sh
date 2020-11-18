#!/bin/bash
packer build -machine-readable --var-file=vars.json template.json | tee build.log
AMI_ID=$(grep 'artifact,0,id' build.log | cut -d, -f6 | cut -d: -f2)
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > amivars.tf
terraform init
terraform apply --auto-approve