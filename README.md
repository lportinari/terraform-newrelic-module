# Terraform Module New Relic for Synthetic Monitoring

## Synops

This terraform module was developed to create the following resources:

- [New Relic Provider](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs)

## Requirements

The below requirements are needed on the host that executes this automation.

- terraform >= 1.1
- newrelic/newrelic >= 3.14.0

## Parameters

**Parameters to use in resource newrelic_synthetics_monitor**

| Parameter | Defaults | Choices | Comments |
|------|---------|---------|-------|
| source |  | `git@github.com:lportinari/terraform-newrelic-module.git//synthetics` | **Required** - Source to reference the module |
| name |  |  | **Required** - Name of the Synthetic monitor  |
| status | `ENABLED` |  |  **Required** - The run state of the monitor |
| period | `EVERY_MINUTE` | `EVERY_MINUTE`, `EVERY_5_MINUTES`, `EVERY_10_MINUTES`, `EVERY_15_MINUTES`, `EVERY_30_MINUTES`, `EVERY_HOUR`, `EVERY_6_HOURS` or `EVERY_12_HOURS` `EVERY_DAY` |  **Required** - Resource Group of the ServiceBus on Azure |
| uri |  |  |  **Requires** - The URI the monitor runs against |
| type |`SIMPLE` | `SIMPLE`, `BROWSER` | **Required** - The monitor type  |
| locations_public | `["AWS_US_WEST_1", "AWS_SA_EAST_1"]` |  | **Required** - The location the monitor will run from. Valid public locations are [here](https://docs.newrelic.com/docs/synthetics/synthetic-monitoring/administration/synthetic-public-minion-ips/)  |
| custom_header name | `null` |  | **Optional** - Custom headers name to use in monitor job  |
| custom_header value | `null` |  | **Optional** - Custom headers value to use in monitor job  |
| treat_redirect_as_failure | `false` | `true`, `false` | **Optional** - Categorize redirects during a monitor job as a failure  |
| validation_string | `null` | `string to be validated` | **Optional** - Validation text for monitor to search for at given URI |
| bypass_head_request | `true` | `true`, `false` | **Optional** - Monitor should skip default HEAD request and instead use GET verb in check  |
| verify_ssl | `false` | `true`, `false` | **Optional** - Name of the Synthetic monitor  |

**Parameters to use in resource newrelic_nrql_alert_condition**

| Parameter | Defaults | Choices | Comments |
|------|---------|---------|-------|
| policy_id |  |  | **Required** - The ID of the policy where this condition should be used  |
| name |  |  | **Required** - The title of the condition  |
| type | `static` | `static`, `baseline` | **Required** - The type of the condition  |
| description | `null` |  | **Optional** - The description of the NRQL alert condition  |
| runbook_url | `null` |  | **Optional** - Runbook URL to display in notifications  |
| enabled | `true` | `true`, `false` | **Optional** - Whether to enable the alert condition  |
| violation_time_limit_seconds |  | `The value must be between 300 seconds (5 minutes) to 2592000 seconds (30 days)` | **Optional** - Sets a time limit, in seconds, that will automatically force-close a long-lasting incident after the time limit you select  |
| aggregation_window | `60` | `The value must be at least 30 seconds, and no more than 900 seconds (15 minutes)` | **Optional** - The duration of the time window used to evaluate the NRQL query, in seconds  |
| aggregation_method | `event_flow` | `cadence`, `event_flow`, `event_timer` | **Optional** - Determines when we consider an aggregation window to be complete so that we can evaluate the signal for incidents  |
| aggregation_delay | `120` | `The maximum delay is 1200 seconds (20 minutes) when using event_flow and 3600 seconds (60 minutes) when using cadence. In both cases, the minimum delay is 0 seconds` | **Optional** - How long we wait for data that belongs in each aggregation window  |
| query |  |  | **Required** - The NRQL query to execute for the condition  |
| critical_operator | `above` | `above`, `above_or_equals`, `below`, `below_or_equals`, `equals`, `not_equals` | **Optional** - Type of operator  |
| critical_threshold |  | `The value is the number of standard deviations from the baseline that the metric must exceed in order to create an incident` | **Required** - The value which will trigger an incident.  |
| critical_threshold_duration |  | `The value must be within 60-86400 seconds (inclusive)` | **Optional** - The duration, in seconds, that the threshold must violate in order to create an incident  |
| threshold_occurrences |  | `all`, `at_least_once` | **Optional** - The criteria for how many data points must be in violation for the specified threshold duration  |

## Examples

Below is an example of using the module:

```hcl
locals {

  monitor = {
    "test_1" = {
      uri                 = "https://www.myurl.com.br"
    }
    "test_2" = {
      uri                 = "https://google.com.br"
    }
  }

  alerts = {
    "test_1 - API is degraded on multiple regions" = {
      type                           = "static"
      description                    = "API is degraded on multiple regions"
      runbook_url                    = "https://www.myrunbook.com"
      enabled                        = true
      violation_time_limit_seconds   = 3600
      fill_option                    = "last_value"
      aggregation_window             = 60
      aggregation_method             = "event_flow"
      aggregation_delay              = 120
      expiration_duration            = 120
      open_violation_on_expiration   = false
      close_violations_on_expiration = true

      query = "SELECT count(result) FROM SyntheticCheck WHERE result = 'FAILED' and monitorName = 'test_1'"

      critical_operator           = "above"
      critical_threshold          = 1
      critical_threshold_duration = 120
    }
    "test_2 - App is degraded on multiple regions" = {
      type                           = "static"
      description                    = "App is degraded on multiple regions"
      runbook_url                    = "https://www.myapprunbook.com"
      enabled                        = true
      violation_time_limit_seconds   = 3600
      aggregation_window             = 60
      aggregation_method             = "event_flow"
      aggregation_delay              = 120

      query = "SELECT count(result) FROM SyntheticCheck WHERE result = 'FAILED' and monitorName = 'test_2'"

      critical_operator           = "above"
      critical_threshold          = 1
      critical_threshold_duration = 120
    }
  }
}
```

## Terraform resources documentation reference

- [Terraform New Relic provider](https://registry.terraform.io/providers/newrelic/newrelic/3.14.0/docs)

## Contributing

Contributions of all forms are welcome. Just open a new issue or pull request.

## License

Apache 2.0 Licensed.
