.PHONY = terravm
script_path = "variables"
script_tfvars = "python.tfvars"

terravm:
	@terraform apply -auto-approve -var-file=${script_path}/${script_tfvars}
