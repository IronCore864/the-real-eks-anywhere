# Network Setup

- Set up two VPCs with IG, NAT with EIP, public/private subnets
- Set up VPC peering
- Set up routing tables and routes, including entries for the VPC peering connections between the two VPCs

The VPC peering part is a stand-alone module to make it more flexible.

So is the routing table / routes module, which will only run after a peering connection is created.
