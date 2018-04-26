variable "name" {
  description = "Desired name for the IAM user"
}

variable "path" {
  description = "Desired path for the IAM user"
  default     = "/"
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key."
  default     = ""
}
