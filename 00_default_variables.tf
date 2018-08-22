variable "name" {
	type = "string"
	default = "test"
}

variable "machine_type" {
	type = "string"
	default = "n1-standard-1"
}

variable "zone" {
	type = "string"
	default = "europe-west2-c"
}

variable "image" {
	type = "string"
	default = "centos-7"
}


variable "network_interface" {
	type = "string"
	default = "default"	
}

variable "user" {
	type = "string"
	default = "terraform"
}

variable "script" {
	default = [ "terrascripts/python_server.sh" ]
}
