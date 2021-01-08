# Update Security Group

This step only does one thing: allow the peered VPC CIDR to access the created EKS cluster. Find the security group, and add an inbound allowing vpc2's CIDR range, so that new node groups to be created in vpc2 can talk to control plane and the nodes in vpc1.

This step is made as a stand-alone step, instead of being integrated with the previous step to keep maximum flexibility (imagine you have multipe VPCs to peer or to use a TGW).

Input is fetched using Terraform remote state from previous steps.
