variable "vm_names" {
  default = ["backend-1", "backend-2"]
}

variable "vm_prefix" {
  default = "bookstore"
}

variable "zone" {
  default = "ru-central1-b"
}

variable "vm_cores" {
  default = 2
}

variable "vm_memory" {
  default = 2
}

variable "image_id" {
  default = "fd8k9sq53kk2ddfo7l37"
}

variable "disk_size" {
  default = 15
}

variable "cidr_block" {
  default = "10.129.0.0/24"
}
