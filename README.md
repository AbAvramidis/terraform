# Files Content Description

- - 00_default : all the variables that we have defined and call from the 02_resources.tf file
- - 01_provider: creates the bond of our project with our credentials and our region
- - 02_resources: template description of the VM (image, name, networking, ssh, scripts)

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
