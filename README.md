# Files Content Description

- 00_default : all the variables that we have defined and call from the 02_resources.tf file
- 01_provider: creates the bond of our project with our credentials and our region
- 02_resources: template description of the VM (image, name, networking, ssh, scripts)
- terrascripts(folder): contain the scripts that we call for the installation of packages, jenkins service, python service
- variables(folder): contain all the .tfvars files with the variables and scripts you want to execute 
- Makefile: automate terraform commands

# terraform

- Commands
        
```sh
$ terraform init #execute this command into the folder
$ terraform plan #description of the VM
$ terraform apply #create the VM
$ terraform destroy #delete the VM
```
- After the creation of the VM with the terraform apply command, follow the steps:
  Google Cloud -> Compute Engine -> VM instances -> SSH button to connect to it through SSH -> BOOM!!! 
  
  
# Variables

- Create a file that contains all your variable that you want to interact with the "resource.tf" file

        variable "user" {
                type = "string"
                default = "terraform"
        }

        variable "script" {
                default = [ "terrascripts/python_server.sh" ]
        }
 
 - Then apply your variables to your resource file like this:
 
         resource "google_compute_instance" "default" {
                name = "${var.name}"
                machine_type = "${var.machine_type}"
                zone = "${var.zone}"
                boot_disk {
                        initialize_params {
                                image = "${var.image}"
                        }

                }
                network_interface {
                        network = "${var.network_interface}"
                        access_config {
                                // IP
                        }
                }
                metadata {
                        sshKeys = "${var.user}:${file("~/.ssh/id_rsa.pub")}"
                }
                provisioner "remote-exec" {
                        connection = {
                                type = "ssh"
                                user = "${var.user}"
                                private_key = "${file("~/.ssh/id_rsa")}"
                        }
                        scripts = "${var.script}"

                }
          }
 
 - Apply Variables - Variable files
```sh 
 terraform apply -var "name=jenkins"
 terraform apply -var-file=variables/jenkins.tfvars
```

- Example of a .tfvars file
```sh
name = "jenkins"
user = "ab"
script = [ "terrascripts/packages.sh" ]
```

- Keep a logging of the process 

You can redirect the installation process into a .txt log file by:
```sh
 terraform apply -var-file=variables/jenkins.tfvars | tee log.txt
```

- Create a **Makefile** that executes the "terraform apply" command by giving as arguments the "variable path" and the ".tfvars" file 
that you want. Assuming that you have create multiple .tfvars files with different scripts or commands.
```sh
.PHONY = terravm
script_path = "variables"
script_tfvars = "python.tfvars"

terravm:
        @terraform apply -auto-approve -var-file=${script_path}/${script_tfvars}
```

 - After that just execute the command:
 
        make terravm

- Improving your Makefile:
```sh
.PHONY = terrainit terraplan terravm terrade
script_path = "variables"
script_tfvars = "python.tfvars"

#initialize a working directory-configuration files
terrainit:
        @terraform init

terraplan:       
        @terraform plan
        
#create-apply a VM
terravm:
        @terraform apply -auto-approve -var-file=${script_path}/${script_tfvars}
        
#destroy the VM
terrade:
        @terraform destroy
```
