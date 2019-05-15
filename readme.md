# Modern Application Design with Web Apps

A collection of demos leveraging Azure Web Apps, including infrastructure as code, Managed Service Identity, and CI/CD pipelines.

## Applications

In the `/src/` directory you can find a collection of applications that each are deployed to an Azure Web App.  These apps represent a variety of tools and technologies that can be used, as well as highlight the seamless integrations available between various services.

### demo-aspnetcore-webapp

An ASP.NET Core application hosting a basic MVC website. This site is connected to a SQLAzure Instance, using Entity Framework Core to interact with the database.  Authentication to the SQLAzure instances is completely keyless and leverages the Managed Service Identity for App Services through the [Microsoft.Azure.Services.AppAuthentication](https://www.nuget.org/packages/Microsoft.Azure.Services.AppAuthentication) nuget package.

### demo-java-webapp

A basic Hello World Java Application.

### demo-ruby-webapp

A containerized Ruby on Rails MVC web application.  This application leverages a sidecar deployment of the [microsoft/oms](https://hub.docker.com/r/microsoft/oms/) container to support logging to Azure Log Analytics.  In the near future the plan is to update this to leverage the Managed Service Identity to pull all configuration from KeyVault.  Work is in progress but not yet complete.

## Infrastructure

In the `/terraform/` directory you will find a collection of Terraform configuration files which define the infrastructure for this project. These Terraform files define an underlying App Service Plan, Key Vault, Application Insights Instance, and other shared resources that are used by the deployed applications, as well as a collection of modules which represent each individual application to be deployed.

## Deployment

In the root of the project there are a collection of `azure-pipelines.*.yml` files which contain build steps for each application, as well as the underlying infrastructure.  In the future as Azure DevOps beings to support multi-stage yaml pipelines all release steps will be moved to here as well.  For the meantime release steps are managed seperately in Azure DevOps.
