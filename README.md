## Run the Terraform Scripts to create Azure Resources

```
cd terraform_codes
terraform init
terraform fmt && terraform vaidate
terraform plan -out main.tfplan
terraform apply "main.tfplan
```

From the terraform output, save the following variables

* `acr_admin_password`
* `acr_admin_username`
* `acr_login_server`
* `resource_group_name`

## Create a service principal

You can create a [service principal](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals#service-principal-object) by using the [az ad sp create-for-rbac](https://docs.microsoft.com/en-us/cli/azure/ad/sp#az-ad-sp-create-for-rbac) command in the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/).

```
az ad sp create-for-rbac --name "AzureFundayDemo" --role contributor --scopes /subscriptions/28296629-48b9-4b8c-81f1-35c3ca4fed0a/resourceGroups/AzureFundayDemo-RG --sdk-auth > creds.json
```

In the above command, replace the placeholders with your subscription ID, and resource group. The output is the role assignment credentials that provide access to your resource. The command should output a JSON object similar to this and save the same into a file called `creds.json`

```
  {
    "clientId": "<GUID>",
    "clientSecret": "<GUID>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
    (...)
  }
```

Copy this JSON object/file, which you will use later.

## Build the application and Deploy locally

```
cd application_codes
npm install
npm run start
```

Import the APIs into `VSCODE ` -> `Thunder Client`

Access the API on `localhost` on port `8080`.

You can use any other REST API Client as well.

## Dockerize your application and push into ACR

```
# Start docker in your workstation
cd application_codes
az acr login --name azurefundaydemoacr.azurecr.io
az acr build --image covid-api:latest --registry azurefundaydemoacr .
```

## Create ContainerApp Environment and ContainerApp (`az cli)`

```
# Install containerapp extension for az cli. Its still in preview.
az extension add --upgrade --name containerapp
az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights

# Create ContainerApp environment with name 'azurefunday-capp-env'
az containerapp env create --name 'azurefunday-capp-env' --resource-group 'AzureFundayDemo-RG' \
                           --internal-only false --location 'East US' \
                           --logs-workspace-id '82ca1c6a-436e-4aee-919d-83923692f8a7' \
                           --logs-workspace-key 'SWlK/ekVB6xeGNA6tVNgRufNAHl4o5n+Pn3XGSB7DROEIIro78thdFXVMDVias8zf5ZgQWtm+ZMzpPaDz/qKPg==' \
                           --tags Owner='AB' Application='Container Apps Demo' Team='Azure Competency team' Approver='AB' StartDate='27-Jul-2022' StopDate='29-Jul-2022'

# Replace the following variables with the terraform output values before creating the containerapp env
- resource_group_name --> (--resource-group)
- location --> (--location)
- log_analytics_workspace_id --> (--logs-workspace-id)
- log_analytics_workspace_shared_key --> (--logs-workspace-key)

# Create ContainerApp with name 'azurefunday-capp'
az containerapp create --name 'azurefunday-capp' --resource-group 'AzureFundayDemo-RG' \
                       --image 'azurefundaydemoacr.azurecr.io/covid-api:latest' --container-name 'covid-api-app' \
                       --environment 'azurefunday-capp-env' --ingress 'external' --target-port 8080 \
                       --registry-server 'azurefundaydemoacr.azurecr.io' \
                       --registry-username 'AzureFundayDemoACR' --registry-password 'WC9GMbmRPSPl1dLa2/QxUfJrFOZRNnMF' \
                       --cpu 0.25 --memory 0.5Gi \
                       --tags Owner='AB' Application='Container Apps Demo' Team='Azure Competency team' Approver='AB' StartDate='27-Jul-2022' StopDate='29-Jul-2022' \
                       --query properties.configuration.ingress.fqdn

```

### Continue Demo on `Azure Portal` and `GitHub`.
