data "azurerm_monitor_diagnostic_categories" "main" {
  count = local.enabled ? 1 : 0

  resource_id = var.resource_id
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  count = local.enabled ? 1 : 0

  name               = local.diag_name
  target_resource_id = var.resource_id

  storage_account_id             = local.storage_id
  log_analytics_workspace_id     = local.log_analytics_id
  log_analytics_destination_type = local.log_analytics_destination_type
  eventhub_authorization_rule_id = local.eventhub_authorization_rule_id
  eventhub_name                  = local.eventhub_name

  dynamic "enabled_log" {
    for_each = local.log_categories

    content {
      category = enabled_log.value

      retention_policy {
        enabled = var.retention_days != null
        days    = var.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = local.metrics

    content {
      category = metric.key
      enabled  = metric.value.enabled

      retention_policy {
        enabled = metric.value.enabled && metric.value.retention_days != null
        days    = metric.value.enabled ? metric.value.retention_days : 0
      }
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
