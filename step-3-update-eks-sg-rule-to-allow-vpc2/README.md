Fetch the security group id from step 2 Terraform output.

Find the security group, and add an inbound allowing vpc2's CIDR range, so that new node groups to be created in vpc2 can talk to control plane and the nodes in vpc1.
