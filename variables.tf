variable "vpc_id" {
  description = "Shared Team VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for app server"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}