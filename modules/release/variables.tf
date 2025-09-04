variable "release" {
  description = "The Helm release name. Defaults to the chart name"
  type        = string
  default     = null
}

variable "namespace" {
  description = "The namespace to deploy into. Defaults to 'default'"
  type        = string
  default     = "default"
}

variable "chart" {
  description = "The Helm chart name"
  type        = string
}

variable "repository" {
  description = "The repository URL for the Helm chart"
  type        = string
  default     = null
}

variable "versions" {
  description = "The Helm chart version"
  type        = string
}

variable "values" {
  description = "The values for the Helm chart. Path can be folder or file"
  type        = list(string)
  default     = []
}

variable "args" {
  description = "The arguments for templating the values files"
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
  description = "The duration to sleep after the Helm release installation."
  type        = string
  default     = null
}