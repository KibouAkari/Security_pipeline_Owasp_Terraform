# ☁️ Infrastructure as Code with Terraform & Azure

This project demonstrates how to provision and manage cloud infrastructure on **Azure** using Terraform. It extends a CI/CD security pipeline by adding automated deployment of the OWASP Juice Shop using Infrastructure as Code (IaC) and GitHub Actions.

## 🌍 Overview

We use Terraform to define and provision the following Azure resources:

- **Resource Group** – Logical container for all resources
- **Azure Container Instance (ACI)** – To run the Juice Shop container
- **Public DNS Label** – For external access to the app
- **Random ID** – To generate unique DNS names

## ⚙️ Technologies Used

- **Terraform** – Infrastructure as Code
- **Azure** – Cloud provider
- **Docker** – Container platform
- **GitHub Actions** – CI/CD pipeline
- **OWASP Juice Shop** – Vulnerable web app for security testing
- **OWASP ZAP** – Automated security scanner

## 📂 Project Structure
    . 
    ├── .github/ 
    │ └── workflows/ 
    │ ├── cicd.yaml # Terraform deployment + tests 
    │ └── zap_scan.yaml # ZAP security scan 
    ├── terraform/ 
    │ ├── main.tf # Azure infrastructure definitions 
    │ ├── variables.tf # Input variables 
    │ ├── providers.tf # Azure provider configuration 
    │ ├── version.tf # Required provider versions 
    ├── tests/ 
    │ └── test_example.py # Placeholder test 
    ├── zap/ 
    │ └── reports/ # ZAP scan reports 
    ├── zap-config/ 
    │ ├── auth.context # (Optional) ZAP context file 
    │ └── zap-policy.xml # (Optional) ZAP scan policy 
    ├── requirements.txt # Python dependencies 
    ├── README.md # Project documentation 
    └── .gitignore
               
## 🚀 Getting Started

1. **Install Prerequisites**  
   - Terraform
   - Azure Subscription + Service Principal
   - GitHub repository with Actions enabled

2. **Configure GitHub Secrets**  
   Add the following secrets to your repository:
   - `AZURE_CLIENT_ID`
   - `AZURE_CLIENT_SECRET`
   - `AZURE_SUBSCRIPTION_ID`
   - `AZURE_TENANT_ID`
   - `AZURE_DNS_LABEL` (after first deployment)

3. **Trigger Deployment**  
   Push to the `main` branch to trigger the GitHub Actions pipeline.

4. **Access the App**  
   After deployment, the Juice Shop will be available at:
http://<AZURE_DNS_LABEL>.switzerlandnorth.azurecontainer.io:3000

5. **Run Security Scan**  
The `zap_scan.yaml` workflow will scan the deployed app and upload a report as an artifact.

## 🔐 Security Practices

- Secrets are managed via GitHub Actions secrets.
- Terraform uses a Service Principal with least-privilege access.
- OWASP ZAP scans for common vulnerabilities (XSS, SQLi, etc.).

## 💡 Goals

- Learn and apply Infrastructure as Code principles with Azure.
- Automate secure deployments using GitHub Actions.
- Integrate security scanning into CI/CD pipelines (DevSecOps).
