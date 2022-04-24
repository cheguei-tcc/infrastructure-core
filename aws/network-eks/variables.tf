variable "iac_environment_tag" {
  default     = "production"
  type        = string
  description = "AWS tag to indicate environment name of each infrastructure object."
}

variable "cluster_name" {
  default     = "cheguei-eks"
  type        = string
  description = "Cheguei EKS Cluster"
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

#### INGRESS AND DNS STUFF

variable "dns_base_domain" {
  default     = "eks.cheguei.app"
  type        = string
  description = "DNS Zone name to be used from EKS Ingress."
}

# kubernetes deployments
variable "deployments_subdomains" {
  default     = ["account-service", "notifier-service"]
  type        = list(string)
  description = "List of subdomains to be routed to Kubernetes Services."
}

# nginx controller stuff
variable "ingress_gateway_chart_name" {
  default     = "ingress-nginx"
  type        = string
  description = "Ingress Gateway Helm chart name."
}

variable "ingress_gateway_chart_repo" {
  default     = "https://kubernetes.github.io/ingress-nginx"
  type        = string
  description = "Ingress Gateway Helm repository name."
}

variable "ingress_gateway_chart_version" {
  default     = "4.1.0"
  type        = string
  description = "Ingress Gateway Helm chart version."
}

variable "ingress_gateway_annotations" {
  default = {
    "controller.service.targetPorts.http"                                                                       = "http",
    "controller.service.targetPorts.https"                                                                      = "http",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"        = "http",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"               = "https",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-connection-idle-timeout" = "3600",
    # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"                    = "elb"
  }

  type        = map(string)
  description = "Ingress Gateway Annotations required for EKS."
}