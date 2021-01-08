aws iam list-instance-profiles-for-role --role-name eks-cluster-test-worker-node-role | jq {"profile_name":.InstanceProfiles[0].InstanceProfileName}
