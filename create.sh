#! /bin/bash

#export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
#export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

terraform init && terraform apply --auto-approve

echo " success"

sleep 5

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Env,Values=dev" --query 'Reservations[].Instances[].PublicIpAddress' --output text)

echo "$a"

#export psw1="$1"

scp -o StrictHostKeyChecking=no -i "$SSH_KEY" docker-compose.yml "$ubuntu"@$a:/home/ubuntu

ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$ubuntu"@$a <<EOF

sudo apt update -y 

sudo apt install -y docker.io

sudo apt install -y docker-compose

sudo mkdir blackbox prometheus grafana

EOF


