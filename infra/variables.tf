variable "kube_ctx" {
  description = "The kubeconfig context to use"
  type        = string
}

variable "kube_config" {
  description = "The path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "gateway_ip" {
  description = "The IP address of the gateway"
  type        = string
  default     = "127.0.0.10"
}