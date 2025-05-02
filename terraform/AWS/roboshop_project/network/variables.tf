variable "vpc" {
  type = map(object({
    cidr = string
  }))
}