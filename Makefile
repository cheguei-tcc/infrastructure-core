eks-create-infra:
	cd cloud/aws/infra-eks && terraform apply && cd ../..

eks-create-network:
	cd cloud/aws/network-eks && terraform apply && cd ../..

eks-destroy-infra:
	cd cloud/aws/infra-eks && terraform destroy && cd ../..

eks-destroy-network:
	cd cloud/aws/network-eks && terraform destroy && cd ../..