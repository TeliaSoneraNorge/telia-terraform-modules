#! /bin/bash

set -euo pipefail

export AWS_DEFAULT_REGION=eu-west-1

latest_ami() {
    local name=$1
    local owner_id=$2

    aws ec2 describe-images \
        --filters \
        "Name=name,Values=${name}" \
        "Name=owner-id,Values=${owner_id}" \
        "Name=architecture,Values=x86_64" \
        "Name=virtualization-type,Values=hvm" \
        "Name=root-device-type,Values=ebs" \
        --query 'Images[*].[ImageId,CreationDate]' \
        --output text \
        | sort -k2 -r \
        | head -n1
}

amazon_linux_1=$(latest_ami amzn-ami-hvm*gp2 137112412989)
echo "Latest Amazon Linux 1:"
echo ${amazon_linux_1}

amazon_ecs_optimized=$(latest_ami amzn-ami*amazon-ecs-optimized 591542846629)
echo "Latest ECS Optimized Amazon linux:"
echo ${amazon_ecs_optimized}

amazon_linux_2=$(latest_ami amzn2-ami-hvm*gp2 137112412989)
echo "Latest Amazon Linux 2:"
echo ${amazon_linux_2}

coreos=$(latest_ami CoreOS-stable* 595879546273)
echo "Latest CoreOS:"
echo ${coreos}

ubuntu=$(latest_ami *ubuntu-xenial-16.04* 099720109477)
echo "Latest Ubuntu:"
echo ${ubuntu}

