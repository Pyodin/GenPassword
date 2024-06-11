# GenPassword
This is a simple app that generates a password for you. You can choose the length of the password and the characters that you want to include in the password. The app will generate a password for you based on your choices.

## Features
- Generate a password with a custom length
- Choose the characters that you want to include in the password
- Copy the password to the clipboard

## Technologies
- Django
- HTML/Bootstrap/JavaScript
- Azure App Service (Linux - Free Tier)
- Terraform
- Azure DevOps

## Deployment
The app is deployed on Azure App Service. The infrastructure is defined using Terraform. You can find the Terraform configuration in the `Infrastructure` folder.

Deployment is done via Azure DevOps. The pipeline is defined in the `azure-web-app-genpassword.yaml` file.

