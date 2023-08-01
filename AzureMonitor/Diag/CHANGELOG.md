# v6.4.1 - 2023-04-28

Fixed
  * [GH-2](https://github.com/claranet/terraform-azurerm-diagnostic-settings/pull/2/files): Fix log categories

# v6.4.0 - 2023-04-28

Changed
  * [GH-2](https://github.com/claranet/terraform-azurerm-diagnostic-settings/pull/2/files): Replace log with `enabled_log` in `azurerm_monitor_diagnostic_setting` due to deprecation
  * [GH-2](https://github.com/claranet/terraform-azurerm-diagnostic-settings/pull/2/files): `logs_destinations_ids` is not nullable anymore

# v6.3.0 - 2023-02-07

Added
  * AZ-993: Allow to exclude some log categories

# v6.2.1 - 2023-01-03

Fixed
  * AZ-968: Fix README

# v6.2.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v6.1.0 - 2022-10-21

Updated
  * AZ-839: Update and optimize module code

Added
  * AZ-846: Properly handle `EventHub` type in log destinations

# v6.0.0 - 2022-09-16

Breaking
  * AZ-839: Require Terraform 1.1+ and AzureRM provider `v3.21.1+`
  * AZ-839: Use the new `logs_category_*` attributes in Azure diagnostics data resource (https://github.com/hashicorp/terraform-provider-azurerm/pull/16367)

# v5.0.0 - 2022-01-12

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

# v4.0.3 - 2021-10-25

Changed
  * AZ-572: Revamp examples and improve CI

Fixed
  * AZ-589: Avoid plan drift when specifying categories

# v4.0.2 - 2021-08-24

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool
  * AZ-530: Cleanup module, fix linter errors

# v4.0.1 - 2020-12-03

Fixed
  * AZ-391: Fix the possibility for an id to be either upper or lower case

# v3.0.0/v4.0.0 - 2020-11-27

Breaking
  * AZ-160: Revamp module

Added
  * AZ-363: Add `log_analytics_destination_type` option (only for DataFactory so far)

Fixed
  * AZ-383: Fix empty logs destinations

## 1.0.0 (2019-05-10)

Added
  * initial release by Innovation Norway ([bfc0361](https://github.com/innovationnorway/terraform-azurerm-diagnostic-settings/commit/bfc0361))
