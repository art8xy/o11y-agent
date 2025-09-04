terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 3.0.1"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.5.0"
    }
  }
}