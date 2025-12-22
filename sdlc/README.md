## Basic

This directory contains the kubernetes configuration files for managing Cloud Infrastructure related to SDLC (Software Development Life Cycle) projects.

The folder is structured as follows:   

```sh
sdlc/
├── README.md               # This file
├── platform /              # Platform is all service controlled by Helm charts
│   ├── staging/                # Base contains all base helm charts
    │   ├── networking/         # Container networking related helm charts
    │   ├── observability/      # OpenTelemetry, Vector, ClickStack, Alert.
    │   └── security/           # Security layer for kubernetes (kyverno).
│   └── production/         # Production contains all production helm charts
└── teams/                  # Teams contains all team specific helm charts
    ├── team-data/          # Team Data related Pod, Deployments, Services, Ingress, Gateway, Secret, ConfigMap, etc. 
    │   ├── staging/
    │   └── production/
    ├── team-frontend/      # Team Frontend related Pod, Deployments, Services, Ingress, Gateway, Secret, ConfigMap, etc.
    │   ├── staging/
    │   └── production/
```

The seperation will help to manage the different environments and teams, ensuring that each team has its own isolated space to deploy and manage their applications while still adhering to the overall platform policies and standards.

The team only need to focus on their applications and not worry about the underlying platform infrastructure, which is managed separately. This allows for better scalability, security, and maintainability of the overall system using Helm charts.

### Deployment

1. **Development**: Teams develop their applications locally or in a development environment.
2. **Containerization**: Applications are containerized using Docker or similar technologies.
3. **GitOps**: Teams push their changes to a Git repository and create a pull request for review.
4. **CI/CD Pipeline**: Upon approval, a CI/CD pipeline is triggered to build, test, and deploy the application to the appropriate environment (staging or production) using Git(Lab/Hub) Workflows / ArgoCD.