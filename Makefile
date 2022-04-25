eks-apply-infra:
	cd aws/infra-eks && terraform apply && cd ../..

eks-apply-config:
	cd aws/config-eks && terraform apply && cd ../..

eks-destroy-infra:
	cd aws/infra-eks && terraform destroy && cd ../..

eks-destroy-config:
	cd aws/config-eks && terraform destroy && cd ../..