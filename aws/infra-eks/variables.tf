variable "instance_name" {
  description = "Value of the Name tag for virtual machine instances"
  type        = string
  default     = "cheguei_vm"
}

variable "cluster_name" {
  default     = "cheguei-eks"
  type        = string
  description = "Cheguei EKS Cluster"
}

# https://aws.amazon.com/pt/ec2/instance-types/

variable "spot_instance_types" {
  default     = ["t3.small", "t3a.small"]
  type        = list(string)
  description = "List of instance types for SPOT instance selection"
}

variable "ondemand_instance_types" {
  default     = ["t3a.small"]
  type        = list(string)
  description = "On Demand instance type"
}

variable "spot_max_size" {
  default     = 3
  type        = number
  description = "How many SPOT instance can be created max"
}

variable "spot_desired_size" {
  default     = 1
  type        = number
  description = "How many SPOT instance should be running at all times"
}

variable "ondemand_max_size" {
  default     = 2
  type        = number
  description = "How many OnDemand instances should be running at all times"
}

variable "ondemand_desired_size" {
  default     = 1
  type        = number
  description = "How many OnDemand instances should be running at all times"
}

variable "iac_environment_tag" {
  default     = "production"
  type        = string
  description = "AWS tag to indicate environment name of each infrastructure object."
}

variable "autoscaling_average_cpu" {
  default     = 70
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
}

variable "region" {
  default     = "sa-east-1"
  type        = string
  description = "AWS Region"
}

variable "profile" {
  default     = "terraform"
  type        = string
  description = "AWS Profile"
}