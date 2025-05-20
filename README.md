
# Azure Node.js App with Terraform

## Introduction
This project demonstrates how to deploy a Node.js application on Azure App Service using Terraform as Infrastructure as Code (IaC). The application is a Node.js Express app that retrieves a dynamic string from Azure App Configuration.

## Prerequisites
- Azure CLI installed and authenticated.
- Terraform installed and authenticated with Azure.
- Node.js installed locally.

## Project Structure
```
.
├── main.tf                # Terraform configuration
├── variables.tf           # Terraform variables
├── outputs.tf             # Terraform outputs
├── app/                   # Node.js application source code
│   ├── index.js           # Node.js Express application
│   ├── package.json       # Node.js dependencies
└── README.md              # Project documentation
```

## Setting Up the Project
1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Replace  subscription_id = "<Azure subscription id>" in `main.tf`.

4. Customize the `variables.tf` file as needed (resource group name, location, etc.).

5. Deploy the Azure resources using Terraform:
   ```bash
   terraform apply
   ```

6. Package the Node.js application for deployment:
   ```bash
   cd app
   zip -r ../app.zip .
   ```

7. Deploy the application using Azure CLI:
   ```bash
   az webapp deploy --resource-group rg-arqiva-demo --name arqiva-node-app --src-path app.zip
   ```

## Usage
- Visit your deployed application URL:
  ```
  https://<your-app-service-name>.azurewebsites.net
  ```

- The application will display the dynamic string stored in Azure App Configuration.

## Troubleshooting
- Ensure the environment variable `SCM_DO_BUILD_DURING_DEPLOYMENT` is set to `true` in Azure.
- Check deployment logs at:
  ```
  https://<your-app-service-name>.scm.azurewebsites.net/api/logs/docker
  ```

## License
This project is licensed under the MIT License.
