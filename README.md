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

##### Continue Demo on `Azure Portal` and `GitHub Action`.
