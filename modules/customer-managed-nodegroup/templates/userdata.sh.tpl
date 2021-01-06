#!/bin/bash -xe

# IMDS v2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 3600")
# get instance details to feed into bootstrap script
az=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone -H "X-aws-ec2-metadata-token: $TOKEN")
instance_type=$(curl -s http://169.254.169.254/latest/meta-data/instance-type -H "X-aws-ec2-metadata-token: $TOKEN")

#set region for aws cli
aws configure set region `curl -s http://169.254.169.254/latest/dynamic/instance-identity/document -H "X-aws-ec2-metadata-token: $TOKEN" | jq -r .region`

# calculate number of max-pods
# https://docs.aws.amazon.com/eks/latest/userguide/cni-custom-network.html
max_if=$(aws ec2 describe-instance-types  --instance-types $${instance_type} --query  InstanceTypes[*].NetworkInfo.MaximumNetworkInterfaces --output text)
max_ips_per_if=$(aws ec2 describe-instance-types  --instance-types $${instance_type} --query  InstanceTypes[*].NetworkInfo.Ipv4AddressesPerInterface --output text)
max_pods=$((($${max_if} -1) * ($${max_ips_per_if} -1 ) + 2))

/etc/eks/bootstrap.sh --b64-cluster-ca '${cluster_auth_base64}' --apiserver-endpoint '${endpoint}' --use-max-pods false --kubelet-extra-args "--node-labels=k8s.amazonaws.com/eniConfig=$${az} --max-pods=$${max_pods}" '${cluster_name}'
systemctl restart docker
