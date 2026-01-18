provider "google" {
	credentials = "${file("~/shared/xxxxx-fe834ddf82b4.json")}"
	project = "xxx"
	region = "europe-west2"
}
