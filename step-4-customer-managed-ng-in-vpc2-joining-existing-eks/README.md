# Additional Customer Managed Node Group in Another VPC

Create a "customer managed" node group to use flexible launch template.

At the moment, managed node group (for example created by EKS) also allows you to bring your own user data script for cusomization.

The purpose of using a "customer managed" (aka, creating your own ASG and LT) is for flexible security group rules configuration so that this new node group can talk to other node groups in other VPCs.
