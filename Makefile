eks-create-infra:
	cd aws/infra-eks && terraform apply && cd ../..

eks-create-config:
	cd aws/network-eks && terraform apply && cd ../..

eks-destroy-infra:
	cd aws/infra-eks && terraform destroy && cd ../..

eks-destroy-config:
	cd aws/network-eks && terraform destroy && cd ../..