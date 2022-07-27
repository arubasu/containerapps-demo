variable "resource_group" {
  default = "AzureFundayDemo-RG"
}

variable "location" {
  default = "East US"
}

variable "container_registry" {
  # should be unique
  default = "AzureFundayDemoACR"
}

variable "load_test" {
  default = "AzureFundayDemo-LT"
}

variable "log_analytics_workspace_name" {
  default = "AzureFundayDemo-LAW"
}

variable "tags" {
  description = "Tags to apply on resource"
  type        = map(string)
  default = {
    Owner       = "AB"
    Application = "Container Apps Demo"
    Team        = "Azure Competency team"
    Approver    = "AB"
    StartDate   = "27-Jul-2022"
    StopDate    = "29-Jul-2022"
  }
}