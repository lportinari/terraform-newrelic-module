variable "policy_name" {
  description = "The name of the policy"
  type = string
}

variable "incident_preference" {
  description = "The rollup strategy for the policy. Options include: PER_POLICY, PER_CONDITION, or PER_CONDITION_AND_TARGET"
  type = string
  default = "PER_POLICY"
}

variable "synthetics_monitor_name" {
  description = "The human-readable identifier for the monitor. valid pubic locations are https://docs.newrelic.com/docs/synthetics/synthetic-monitoring/administration/synthetic-public-minion-ips/"
  type = string
}

variable "synthetics_monitor_period" {
  description = "The interval at which this monitor should run. Valid values are EVERY_MINUTE, EVERY_5_MINUTES, EVERY_10_MINUTES, EVERY_15_MINUTES, EVERY_30_MINUTES, EVERY_HOUR, EVERY_6_HOURS, EVERY_12_HOURS, or EVERY_DAY"
  type = string
  default = "EVERY_MINUTE"
}

variable "application_url" {
  description = "The application URL"
  type = string
}

variable "synthetics_public_location" {
  description = "The location the monitor will run from."
  type = list(string)
  default = ["AWS_US_WEST_1", "AWS_SA_EAST_1"]
}

variable "synthetics_treat_redirect_as_failure" {
  description = "Categorize redirects during a monitor job as a failure"
  type = bool
  default = false
}

variable "synthetics_bypass_head_request" {
  description = "Monitor should skip default HEAD request and instead use GET verb in check"
  type = bool
  default = true
}

variable "synthetics_verify_ssl" {
  description = "Monitor should validate SSL certificate chain"
  type = bool
}

variable "synthetics_alert_condition_name" {
  description = "The title of this condition"
  type = string
}

variable "synthetics_runbook_url" {
  description = "Runbook URL to display in notifications"
  type = string
  default = null
}

variable "synthetics_multilocation_alert_name" {
  description = "The title of the condition"
  type = string
}

variable "synthetics_multilocation_violation_time_limit_seconds" {
  description = "The maximum number of seconds a violation can remain open before being closed by the system. Must be one of: 0, 3600, 7200, 14400, 28800, 43200, 86400"
  type = string
}