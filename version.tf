terraform {
  required_version = ">= 1.0.0"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.14.0"
    }
  }
}