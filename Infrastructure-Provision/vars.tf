variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "REGION" {
  default = "us-east-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "inst" {
  default = "t2.micro"
}
