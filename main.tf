resource "newrelic_alert_policy" "foo" {
  name = "example"
  incident_preference = "PER_POLICY"
}

resource "newrelic_synthetics_monitor" "monitor" {
  status            = "ENABLED"
  name              = "first_monitor"
  period            = "EVERY_MINUTE"
  uri               = "https://www.asfhoadof.com"
  type              = "SIMPLE"
  locations_public = ["AWS_US_WEST_1", "AWS_SA_EAST_1"]

  treat_redirect_as_failure = true
  # validation_string         = "Healthy"
  bypass_head_request = true
  verify_ssl          = true
}

resource "newrelic_synthetics_alert_condition" "foo" {
  policy_id = newrelic_alert_policy.foo.id

  name        = "foo"
  monitor_id  = newrelic_synthetics_monitor.monitor.id
  runbook_url = "https://www.example.com"
}

resource "newrelic_synthetics_multilocation_alert_condition" "example" {
  policy_id = newrelic_alert_policy.foo.id

  name                         = "Example condition"
  runbook_url                  = "https://example.com"
  enabled                      = true
  violation_time_limit_seconds = "3600"

  entities = [
    newrelic_synthetics_monitor.monitor.id
  ]

  critical {
    threshold = 2
  }

  warning {
    threshold = 1
  }
}

resource "newrelic_notification_destination" "notification_destination_email" {
  # account_id = 12345678
  name = "email-example"
  type = "EMAIL"

  property {
    key = "email"
    value = "lvp.celinski@gmail.com"
  }
}

resource "newrelic_notification_channel" "notification_example" {
  # account_id = 12345678
  name = "email-example"
  type = "EMAIL"
  destination_id = newrelic_notification_destination.notification_destination_email.id
  product = "IINT"

  property {
    key = "subject"
    value = "Synthetic error"
  }
}

resource "newrelic_workflow" "workflow-example" {
  name = "workflow-example"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "Filter-name"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator = "EXACTLY_MATCHES"
      values = [ newrelic_alert_policy.foo.id ]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.notification_example.id
  }
}