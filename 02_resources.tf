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
