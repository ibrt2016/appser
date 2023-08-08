resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# module "logs" {
#   source  = "claranet/run-common/azurerm//modules/logs"
#   #version = "x.x.x"

#   client_name         = var.client_name
#   environment         = var.environment
#   stack               = var.stack
#   location            = azurerm_resource_group.example.location
#   location_short      = "eus"
#   resource_group_name = azurerm_resource_group.example.name
# }

module "app_service_plan" {
  source  = "./AppServices/AppServicePlan"


  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  location_short      = "eus"

  # logs_destinations_ids = [
  #   module.logs.logs_storage_account_id,
  #   module.logs.log_analytics_workspace_id
  # ]

  os_type  = "Linux"
  sku_name = "B2"

  extra_tags = {
    foo = "bar"
  }
  depends_on = [ azurerm_resource_group.example ]
}

module "container_web_app" {
  source  = "./AppServices/container-web-app"
  
  client_name         = var.client_name
  environment         = var.environment
  location            = azurerm_resource_group.example.location
  location_short      = "eus"
  resource_group_name = azurerm_resource_group.example.name
  stack               = var.stack

  service_plan_id = module.app_service_plan.service_plan_id

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL = "https://myacr.azurecr.io"
    FOO                        = "bar"
  }

 docker_image_name = "nginx:latest"
 docker_image_name_slot = "nginx:v2"
 docker_registry_url = "https://myacr.azurecr.io"
 docker_registry_username = "111"
 docker_registry_password = "pass"
  site_config = {
    linux_fx_version = "DOCKER|myacr.azurecr.io/myrepository/image:tag"
    http2_enabled    = true

    # The "AcrPull" role must be assigned to the managed identity in the target Azure Container Registry
    acr_use_managed_identity_credentials = true
  }

  auth_settings = {
    enabled             = true
    token_store_enabled = true

    active_directory = {
      client_id         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      client_secret     = "xxxxxxxxxxxxxxxxxxxxx"
      allowed_audiences = ["https://www.example.com"]
    }
  }

  auth_settings_v2 = {
    auth_enabled = true
    require_authentication = true
    default_provider = "myOidc"
    custom_oidc_v2 = {
      name = "myOidc"
      client_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      openid_configuration_endpoint = "https://www.example.com"
    }

  }

  # custom_domains = {
  #   # Custom domain with SSL certificate file
  #   # "example.com" = {
  #   #   certificate_file     = "./example.com.pfx"
  #   #   certificate_password = "xxxxxxxxx"
  #   # }
  #   # Custom domain with SSL certificate stored in a keyvault
  #   # "example2.com" = {
  #   #   certificate_keyvault_certificate_id = var.certificate_keyvault_id
  #   # }
  #   # Custom domain without SSL certificate
  #   "example3.com" = null
  #   # Custom domain with an existant SSL certificate
  #   # "exemple4.com" = {
  #   #   certificate_id = var.certificate_id
  #   # }
  # }

  authorized_ips = ["1.2.3.4/32", "4.3.2.1/32"]

  ip_restriction_headers = {
    x_forwarded_host = ["myhost1.fr", "myhost2.fr"]
  }
  scm_ip_restriction_headers = {
    x_forwarded_host = ["myhost1.fr", "myhost2.fr"]
  }

  staging_slot_custom_app_settings = {
    John = "Doe"
  }

  extra_tags = {
    foo = "bar"
  }

  # mount_points = [
  #   {
  #     account_name = azurerm_storage_account.assets_storage.name
  #     share_name   = azurerm_storage_share.assets_share.name
  #     access_key   = azurerm_storage_account.assets_storage.primary_access_key
  #     mount_path   = "/var/www/html/assets"
  #   }
  # ]

  # logs_destinations_ids = [
  #   module.logs.logs_storage_account_id,
  #   module.logs.log_analytics_workspace_id,
  # ]

  depends_on = [ module.app_service_plan ]
}