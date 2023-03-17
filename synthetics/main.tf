data "newrelic_alert_policy" "alert_policy" {
  name = var.newrelic_alert_policy_id
}

resource "newrelic_synthetics_monitor" "monitor" {
  for_each         = var.synthetics_monitor_name
  name             = each.key
  status           = try(each.value.status, "ENABLED")
  period           = try(each.value.period, "EVERY_MINUTE")
  uri              = each.value.uri
  type             = try(each.value.type, "SIMPLE")
  locations_public = try(each.value.locations_public, ["AWS_US_WEST_1", "AWS_SA_EAST_1"])
  custom_header {
    name  = try(each.value.custom_header_name, null)
    value = try(each.value.custom_header_value, null)
  }
  treat_redirect_as_failure = try(each.value.treat_redirect_as_failure, false)
  validation_string         = try(each.value.validation_string, null)
  bypass_head_request       = try(each.value.bypass_head_request, true)
  verify_ssl                = try(each.value.verify_ssl, false)
}

resource "newrelic_nrql_alert_condition" "nrql_alert" {
  policy_id                      = data.newrelic_alert_policy.alert_policy.id
  for_each                       = var.nrql_alert_name
  name                           = each.key
  type                           = try(each.value.type, "static")
  description                    = try(each.value.description, null)
  runbook_url                    = try(each.value.runbook_url)
  enabled                        = try(each.value.enabled, true)
  violation_time_limit_seconds   = try(each.value.violation_time_limit_seconds)
  aggregation_window             = try(each.value.aggregation_window, 60)
  aggregation_method             = try(each.value.aggregation_method, "event_flow")
  aggregation_delay              = try(each.value.aggregation_delay, 120)

  nrql {
    query = try(each.value.query)
  }

  critical {
    operator              = try(each.value.critical_operator, "above")
    threshold             = try(each.value.critical_threshold)
    threshold_duration    = try(each.value.critical_threshold_duration)
    threshold_occurrences = "ALL"
  }
}
