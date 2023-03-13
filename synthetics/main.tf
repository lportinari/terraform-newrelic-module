resource "newrelic_synthetics_monitor" "monitor" {
  status           = "ENABLED"
  name             = var.synthetics_monitor_name
  period           = var.synthetics_monitor_period
  uri              = var.application_url
  type             = "SIMPLE"
  locations_public = var.synthetics_public_location

  treat_redirect_as_failure = var.synthetics_treat_redirect_as_failure
  validation_string         = var.synthetics_validation_string
  bypass_head_request = var.synthetics_bypass_head_request
  verify_ssl          = var.synthetics_verify_ssl
}

resource "newrelic_synthetics_multilocation_alert_condition" "synthetics_multilocation_alert" {
  policy_id = var.policy_id

  name                         = var.synthetics_multilocation_alert_name
  runbook_url                  = var.synthetics_runbook_url
  enabled                      = true
  violation_time_limit_seconds = var.synthetics_multilocation_violation_time_limit_seconds

  entities = [
    newrelic_synthetics_monitor.monitor.id
  ]

  critical {
    threshold = var.synthetics_multilocation_critical_threshold
  }

  warning {
    threshold = var.synthetics_multilocation_warning_threshold
  }
}