#!bin/bash/
terraform init
terraform fmt
terraform validate
terraform plan
sleep 10 #Time in seconds for you to review your work. You can increase or reduce time.
terraform apply --auto-approve
#sleep 60 #Time in seconds for you to review your work. You can increase or reduce time.
#terraform destroy --auto-approve

#To execute the script on you terminal
#run sh terraform.sh file
#This has to be in the same folder as the main.ft file for your resources

#To the script from a different folder, add the file path to the commands
#example; terraform init ~/documents
