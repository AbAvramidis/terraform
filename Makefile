.PHONY = terrainit terraplan terravm terrade
script_path = "variables"
script_tfvars = "python.tfvars"

#initialize a working directory-configuration files
terrainit:
	@terraform init

terraplan:
	@terraform plan

terravm:
	@terraform apply -auto-approve -var-file=${script_path}/${script_tfvars}

terrade:
	@terraform destroy
