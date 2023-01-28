# --- comput/variables.tf ---
variable "jenks_instance_type" {
  type    = string
  default = "t2.large"
}

variable "regions" {
  type    = string
  default = "us-east-1a"
}

###AMI
variable "key" {
  type    = string
  default = "minhaaws"
}
 ##Amazonlinux2 'us-east-1'
variable "amazonlinux2" {
  type    = string
  default = "ami-0b93ce03dcbcb10f6"
}

 ##ubuntu 'us-east-1'
variable "ubuntu2004" {
  type    = string
  default = "ami-0b93ce03dcbcb10f6"
}

#Servidores
variable "jenkinsServer" {
  type    = string
  default = "Jenkins*Server"
}


variable "admin" {
  type    = string
  default = "kubenews"
}

variable "senha" {
  type    = string
  default = "Pg#kubenews"
}

variable "rds_instance_type" {
  type    = string
  default = "db.t3.micro"
}

