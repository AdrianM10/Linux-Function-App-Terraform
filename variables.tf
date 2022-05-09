variable "rgname" {
  type    = string
  default = "Amaterasu-RG"

}

variable "rglocation" {
  type    = string
  default = "eastus"
}

variable "storage" {
  type    = string
  default = "amaterasustr"
}

variable "appserviceplan" {
  type    = string
  default = "amaterasu-app-service-plan"

}

variable "function" {
  type    = string
  default = "amaterasu-app"
}

variable "appslot" {
  type    = string
  default = "amaterasu-dev-slot"

}
