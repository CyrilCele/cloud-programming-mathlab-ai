variable "domain_name" {
  description = "Domain name."

  type = string
}

variable "tags" {
  description = "Common tags."

  type = map(string)
}
