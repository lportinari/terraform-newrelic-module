variable "policy_name" {
  description = "The name of the policy"
  type        = string
}

variable "incident_preference" {
  description = "The rollup strategy for the policy. Options include: PER_POLICY, PER_CONDITION, or PER_CONDITION_AND_TARGET"
  type        = string
  default     = "PER_POLICY"
}

variable "synthetics_monitor_name" {
  description = "The human-readable identifier for the monitor. valid pubic locations are https://docs.newrelic.com/docs/synthetics/synthetic-monitoring/administration/synthetic-public-minion-ips/"
  type        = string
}

variable "synthetics_monitor_period" {
  description = "The interval at which this monitor should run. Valid values are EVERY_MINUTE, EVERY_5_MINUTES, EVERY_10_MINUTES, EVERY_15_MINUTES, EVERY_30_MINUTES, EVERY_HOUR, EVERY_6_HOURS, EVERY_12_HOURS, or EVERY_DAY"
  type        = string
  default     = "EVERY_MINUTE"
}

variable "application_url" {
  description = "The application URL"
  type        = string
}

variable "synthetics_public_location" {
  description = "The location the monitor will run from."
  type        = list(string)
  default     = ["AWS_US_WEST_1", "AWS_SA_EAST_1"]
}

variable "synthetics_treat_redirect_as_failure" {
  description = "Categorize redirects during a monitor job as a failure"
  type        = bool
  default     = false
}

variable "synthetics_bypass_head_request" {
  description = "Monitor should skip default HEAD request and instead use GET verb in check"
  type        = bool
  default     = true
}

variable "synthetics_verify_ssl" {
  description = "Monitor should validate SSL certificate chain"
  type        = bool
}

variable "synthetics_alert_condition_name" {
  description = "The title of this condition"
  type        = string
}

variable "synthetics_runbook_url" {
  description = "Runbook URL to display in notifications"
  type        = string
  default     = null
}

variable "synthetics_multilocation_alert_name" {
  description = "The title of the condition"
  type        = string
}

variable "synthetics_multilocation_violation_time_limit_seconds" {
  description = "The maximum number of seconds a violation can remain open before being closed by the system. Must be one of: 0, 3600, 7200, 14400, 28800, 43200, 86400"
  type        = string
}

variable "synthetics_multilocation_critical_threshold" {
  description = "A condition term with the priority set to critical"
  type        = number
  default     = 2
}

variable "synthetics_multilocation_warning_threshold" {
  description = "A condition term with the priority set to warning"
  type        = number
  default     = 1
}

variable "notification_destination_name" {
  description = "The name of the destination"
  type        = string
}

variable "notification_destination_type" {
  description = "The type of destination. One of: EMAIL, SERVICE_NOW, WEBHOOK, JIRA, MOBILE_PUSH, EVENT_BRIDGE, PAGERDUTY_ACCOUNT_INTEGRATION or PAGERDUTY_SERVICE_INTEGRATION"
  type        = string
  default     = "EMAIL"
}

variable "notification_destination_email" {
  description = "The notification property email"
  type        = string
}

variable "notification_channel_name" {
  description = "The name of the channel"
  type        = string
}

variable "notification_channel_type" {
  description = "The type of channel. One of: EMAIL, SERVICENOW_INCIDENTS, WEBHOOK, JIRA_CLASSIC, MOBILE_PUSH, EVENT_BRIDGE, SLACK and SLACK_COLLABORATION, PAGERDUTY_ACCOUNT_INTEGRATION or PAGERDUTY_SERVICE_INTEGRATION"
  type        = string
}

variable "notification_channel_key" {
  description = "The notification property key"
  type        = string
}

variable "notification_channel_value" {
  description = "The notification property value"
  type        = string
}

variable "workflow_name" {
  description = "The name of the workflow"
  type        = string
}

variable "workflow_muting_rules_handling" {
  description = "How to handle muted issues. See details: https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/workflow#muting-rules"
  type        = string
  default     = "NOTIFY_ALL_ISSUES"
}

variable "workflow_issues_filter_name" {
  description = "The name of the filter. The name only serves a cosmetic purpose and can only be seen through Terraform and GraphQL API. It can't be empty"
  type        = string
}

variable "workflow_predicate_attribute" {
  description = "Issue event attribute to check"
  type        = string
}

variable "workflow_predicate_operator" {
  description = "An operator to use to compare the attribute with the provided values, see supported operators below"
  type        = string
  default     = "EXACTLY_MATCHES"
}