# villvay

# Prerequisites.

following softwares needs to be installed in the system to run below steps.
  
  git
  
  packer
  
  terraform
  
  ansible
  
  awscli
  

# Provision Infrastructure.


1. Clone git repository

    https://github.com/ramshek/villvay.git

2. change directory to Infrastructure-Provision

    cd Infrastructure-Provision
  
3. run build script
  
    sh build.sh
    


# Destroy Infrastructure.

1. run destroy script

    sh destroy.sh
    
# Deploy New Application.

assumption: Ansible control machine should deploy to Public Subnet of Vallvay VPC as Ansible use private ip's to connect with Managed Nodes in this script.

1. Clone git repository

    https://github.com/ramshek/villvay.git
    
2. Change Directory to Ansible 
  
    cd Ansible
    
3. Run Below Command

  ansible-playbook -i ec2.py --limit "tag_Name_villvay" ansible-deploy.yml -u ec2-user  --key-file mykey

# S3 Bucket Access Control.

  Best Option to restrict s3 is control access only to VPC. For this we need to create a VPC Endpoint. This will allow to traverse traffic via AWS network.
  
  Steps:
   
   1. Create a VPC Endpoint.
   
   2. Attach S3 Bucket Policy. (https://github.com/ramshek/villvay/blob/main/bucket-policy.json)
   
   
