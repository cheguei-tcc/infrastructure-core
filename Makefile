eks-create-infra:
	cd aws/infra-eks && terraform apply && cd ../..

eks-create-network:
	cd aws/network-eks && terraform apply && cd ../..