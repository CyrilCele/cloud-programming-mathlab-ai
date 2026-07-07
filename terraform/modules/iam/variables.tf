variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}
