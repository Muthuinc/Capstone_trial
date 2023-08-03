#! /bin/bash

export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

export psw1="$1"

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Env,Values=prod" --query 'Reservations[].Instances[].PublicIpAddress' --output text)

scp -o StrictHostKeyChecking=no -i "$psw1" blackbox.yml ubuntu@$a:/home/ubuntu

scp -o StrictHostKeyChecking=no -i "$psw1" prometheus.yml ubuntu@$a:/home/ubuntu

scp -o StrictHostKeyChecking=no -i "$psw1" docker-compose1.yml ubuntu@$a:/home/ubuntu

ssh -o StrictHostKeyChecking=no -i "$psw1" ubuntu@$a <<EOF

sudo docker-compose1 up -d

EOF