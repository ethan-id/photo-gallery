terraform {
  backend "gcs" {
    bucket = "photo-gallery-tf-ethanid"
    prefix = "state"
  }
}
