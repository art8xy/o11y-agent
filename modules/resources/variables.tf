variable "release" {
  description = "The name of the Helm Release. Defaults to a random UUID."
  type        = string
  default     = null
}

variable "namespace" {
  description = "The namespace in which to install the resources. Defaults to 'default'."
  type        = string
  default     = "default"
}

variable "paths" {
  description = "Kubernetes manifests to deploy. Can be a file or a directory."
  type        = list(string)
}

variable "args" {
  description = "Arguments to pass to the manifest templates."
  type        = any
  default     = {}
}

variable "timeout" {
  description = "The timeout for the Helm release installation."
  type        = number
  default     = 500
}

variable "wait" {
  description = "Whether to wait for pods to be ready. Defaults to true"
  type        = bool
  default     = true
}

variable "sleep" {
  description = "The duration to sleep after the resources installation."
  type        = string
  default     = null
}