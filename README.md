# Ensuring Quality Releases - Project

This project focuses on leveraging industry-leading tools, particularly Microsoft Azure, to establish a robust pipeline for creating disposable test environments, running automated tests effortlessly, and ensuring the quality of software releases.

## Overview

### Pipeline Resources

This CI/CD pipeline will generate the following essential resources:

* Resource Group
* App Service
* Virtual Network
* Network Security Group
* Virtual Machine

These resources are orchestrated to deploy a demo REST API within the App Service, while comprehensive automated tests are executed against the REST API from a virtual machine created using Terraform in the CI/CD pipeline.

### Tests

The pipeline includes automated tests developed using 
* *Postman* for API Testing (Integration Testing)
* *JMeter* for Performance Testing
* *Selenium* using Chromedriver for Functional UI Testing
