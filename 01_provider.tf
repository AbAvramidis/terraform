provider "google" {
	credentials = "${file("~/shared/iliasproject-214108-fe834ddf82b4.json")}"
	project = "iliasproject-214108"
	region = "europe-west2"
}
