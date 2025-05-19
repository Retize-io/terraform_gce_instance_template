variable "disk_size" {
  description = "Size of the boot disk for the VM in GB"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Type of disk to use for the VM's boot disk"
  type        = string
  default     = "pd-standard"
}

variable "os_source_image" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "machine_type" {
  description = "Type of machine to use for the VM"
  type        = string
  default     = "n1-standard-1"
}

variable "network_tags" {
  description = "List of network tags to attach to the instance"
  type        = list(string)
  default     = []
}

variable "startup_script" {
  description = "The contents of the startup script to run on the instance"
  type        = string
}

variable "startup_script_url" {
  description = "The URL of the startup script to download and run on the instance"
  type        = string
}

variable "service_name" {
  description = "Name of the service to be created"
  type        = string
}

variable "service_account_email" {
  description = "Email of the service account to be used for the VM"
  type        = string
}

variable "network" {
  description = "Name of the network to use for the VM"
  type        = string
  default     = "retigazer-network"
}

variable "subnetwork" {
  description = "Name of the subnetwork to use for the VM"
  type        = string
  default     = "default"
}

variable "region" {
  description = "The region in which to create the resources"
  type        = string
  default     = "us-central1"
}

variable "project_id" {
  description = "The ID of the project in which to create the resources"
  type        = string
}
