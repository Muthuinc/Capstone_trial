#! /bin/bash

#export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
#export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

#export psw1="$1"

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Env,Values=prod" --query 'Reservations[].Instances[].PublicIpAddress' --output text)

sed -i "s/EC2_ip/$a/g" prometheus.yml

scp -o StrictHostKeyChecking=no -i "$SSH_KEY" blackbox.yml "$ubuntu"@$a:/home/ubuntu/blackbox

scp -o StrictHostKeyChecking=no -i "$SSH_KEY" prometheus.yml "$ubuntu"@$a:/home/ubuntu/prometheus

scp -o StrictHostKeyChecking=no -i "$SSH_KEY" grafana.ini "$ubuntu"@$a:/home/ubuntu/grafana

scp -o StrictHostKeyChecking=no -i "$SSH_KEY" docker-compose1.yml "$ubuntu"@$a:/home/ubuntu

ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$ubuntu"@$a <<EOF

sudo docker-compose1 up -d

EOF
