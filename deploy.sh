#! /bin/bash

#export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
#export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

a=$(aws ec2 describe-instances --region ap-south-1 --filters "Name=tag:Env,Values=prod" --query 'Reservations[].Instances[].PublicIpAddress' --output text)
export psw1="$1"
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$ubuntu"@$a <<EOF


sudo GIT_COMMIT=$GIT_COMMIT docker-compose up -d


if curl localhost:80
then
  echo "success"
fi

EOF
