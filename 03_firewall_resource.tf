resource "google_compute_firewall" "default" {
	name = "${var.name}-firewall"
	network = "${var.network_interface}"
	source_tags = ["${var.name}"]
	source_ranges = ["0.0.0.0/0"]
	allow{
		protocol = "icmp"
	}
	allow {
		protocol = "tcp"
		ports = ["22", "9000", "8080"]
	}

}
