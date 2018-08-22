provider "google" {
	credentials = "${file("~/credentials.json")}"
	project = "iliasproject-214108"
	region = "europe-west2"
}
