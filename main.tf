resource "newrelic_alert_policy" "alert_policy" {
  name                = var.policy_name
  incident_preference = var.incident_preference
}

resource "newrelic_synthetics_monitor" "monitor" {
  status           = "ENABLED"
  name             = var.synthetics_monitor_name
  period           = var.synthetics_monitor_period
  uri              = var.application_url
  type             = "SIMPLE"
  locations_public = var.synthetics_public_location

  treat_redirect_as_failure = var.synthetics_treat_redirect_as_failure
  # validation_string         = "Healthy"
  bypass_head_request = var.synthetics_bypass_head_request
  verify_ssl          = var.synthetics_verify_ssl
}

resource "newrelic_synthetics_alert_condition" "synthetics_condition" {
  policy_id = newrelic_alert_policy.alert_policy.id

  name        = var.synthetics_alert_condition_name
  monitor_id  = newrelic_synthetics_monitor.monitor.id
  runbook_url = var.synthetics_runbook_url
}

resource "newrelic_synthetics_multilocation_alert_condition" "synthetics_multilocation_alert" {
  policy_id = newrelic_alert_policy.alert_policy.id

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

resource "newrelic_notification_destination" "notification_destination_email" {
  # account_id = 12345678
  name = var.notification_destination_name
  type = var.notification_destination_type

  property {
    key   = "email"
    value = var.notification_destination_email
  }
}

resource "newrelic_notification_channel" "notification_channel" {
  # account_id = 12345678
  name           = var.notification_channel_name
  type           = var.notification_channel_type
  destination_id = newrelic_notification_destination.notification_destination_email.id
  product        = "IINT"

  property {
    key   = var.notification_channel_key
    value = var.notification_channel_value
  }
}

resource "newrelic_workflow" "workflow" {
  name                  = var.workflow_name
  muting_rules_handling = var.workflow_muting_rules_handling

  issues_filter {
    name = var.workflow_issues_filter_name
    type = "FILTER"

    predicate {
      attribute = var.workflow_predicate_attribute
      operator  = var.workflow_predicate_operator
      values    = [newrelic_alert_policy.alert_policy.id]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.notification_channel.id
  }
}