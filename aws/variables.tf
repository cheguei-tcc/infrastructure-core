variable "instance_name" {
  description = "Value of the Name tag for virtual machine instances"
  type        = string
  default     = "cheguei_vm"
}

variable "clustername" {
  default     = "chegueiEKS"
  description = "Cheguei EKS Cluster"
}

variable "spot_instance_types" {
  default     = ["t3.small", "t3a.small"]
  description = "List of instance types for SPOT instance selection"
}

variable "ondemand_instance_type" {
  default     = "t3a.small"
  description = "On Demand instance type"
}

variable "spot_max_size" {
  default     = 4
  description = "How many SPOT instance can be created max"
}

variable "spot_desired_size" {
  default     = 1
  description = "How many SPOT instance should be running at all times"
}

variable "ondemand_desired_size" {
  default     = 1
  description = "How many OnDemand instances should be running at all times"
}

variable "region" {
  default = "sa-east-1"
  description = "AWS Region"
}