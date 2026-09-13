# FinPulse — Global Fintech Job Portal & Market Intelligence

[![Fintech Job Portal CI/CD Pipeline](https://github.com/rajnadar/june-2026/actions/workflows/cicd.yml/badge.svg)](https://github.com/rajnadar/june-2026/actions/workflows/cicd.yml)
[![Docker Image](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/)
[![.NET 8.0](https://img.shields.io/badge/.NET-8.0%20LTS-purple.svg)](https://dotnet.microsoft.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**FinPulse** is an enterprise-grade financial technology job portal and real-time aggregator built with **C# / .NET 8**, **ASP.NET Core Web API**, and a sleek **Dark/Neon Glassmorphic SPA**. It consolidates high-paying careers across Wall Street quantitative hedge funds, tier-1 payment gateways, digital asset exchanges, neo-banks, wealth management platforms, and AI risk engines into a single unified dashboard.

---

## 🌟 Key Features

- 🔎 **Unified Multi-Source Aggregation**: Real-time connectors aggregating roles from **Citadel Securities**, **Stripe**, **Two Sigma**, **Coinbase**, **Revolut**, **Plaid**, **Bloomberg**, **Adyen**, and **Chainalysis**.
- 📊 **Fintech Sector Taxonomy**:
  - *Quant & Algorithmic Trading (Low-latency C++, C#, FPGA)*
  - *Payments & Open Banking (ISO 20022, FedNow, Core Rails)*
  - *Neo-Banking & Core Banking Ledgers*
  - *Blockchain & Digital Assets (Solidity, Rust, Cryptographic Custody)*
  - *WealthTech & Automated Robo-Advisory*
  - *Risk, AI & Anti-Money Laundering (AML)*
  - *Fintech Cloud & SRE Infrastructure*
- 💰 **Salary & Compensation Transparency**: Detailed base salary ranges, equity stock grants (RSUs), and performance bonus pools.
- ⚡ **Real-Time Search & Faceted Filtering**: Fast multi-criteria filter by keyword, domain, tech stack, remote vs hybrid, and experience level.
- 📈 **Market Intelligence Analytics**: Live salary benchmarks by sector, in-demand skill leaderboards, and top global financial hubs (New York, London, Singapore, Amsterdam, San Francisco).
- 📌 **Interactive Saved Roles**: LocalStorage-persisted bookmarks drawer.
- 🔔 **Fintech Job Alerts**: Instant subscription for automated candidate notifications.
- 📄 **OpenAPI / Swagger Documentation**: Self-documenting RESTful API endpoints at `/swagger`.

---

## 🏛 Solution Architecture

```
june-2026/
├── .github/
│   └── workflows/
│       └── cicd.yml                      # GitHub Actions: Build, Test, Package, Docker Hub Push
├── src/
│   ├── FintechJobPortal.Core/            # Domain models, enums & interfaces
│   │   ├── Enums/                        # FintechCategory, ExperienceLevel, LocationType
│   │   └── Models/                       # JobListing, Company, JobSearchQuery, MarketAnalytics
│   ├── FintechJobPortal.Services/        # Multi-portal aggregation & analytics engine
│   │   ├── Interfaces/                   # IJobAggregatorService, IJobProvider, IMarketAnalyticsService
│   │   ├── Providers/                    # Dedicated connectors (HedgeFund, Stripe, Coinbase, etc.)
│   │   └── Services/                     # JobAggregatorService, MarketAnalyticsService
│   └── FintechJobPortal.Web/             # ASP.NET Core 8 Web API & Frontend SPA
│       ├── Controllers/                  # JobsController, AnalyticsController, HealthController
│       ├── Program.cs                    # Dependency injection & pipeline bootstrapping
│       └── wwwroot/                      # Dark/Neon UI (index.html, style.css, app.js)
├── tests/
│   └── FintechJobPortal.Tests/           # xUnit Unit & Integration Test Suite
├── Dockerfile                            # Multi-stage build, test, publish & Alpine runtime
├── .dockerignore                         # Docker layer optimization
├── docker-compose.yml                    # Local single-command orchestration
└── FintechJobPortal.sln                  # Visual Studio Solution File
```

---

## 🚀 Running with Docker (Recommended)

Everything can be built and executed entirely within Docker:

### 1. Launch with Docker Compose
```bash
docker compose up --build
```
The application will be live at **`http://localhost:8080`**.

### 2. Launch with Plain Docker Commands
```bash
# Build production container image
docker build -t fintech-job-portal:latest .

# Run container on port 8080
docker run -d -p 8080:8080 --name fintech-app fintech-job-portal:latest
```

### 3. Run Automated Tests inside Docker
```bash
docker build --target test -t fintech-job-portal:test .
```

---

## 🛠 Local Development (.NET 8 SDK)

If you have the .NET 8 SDK installed locally:

```bash
# Restore NuGet packages
dotnet restore

# Build solution in Release mode
dotnet build -c Release

# Run automated xUnit tests
dotnet test

# Start the Web Application
dotnet run --project src/FintechJobPortal.Web
```

Open your browser to:
- **Web Portal UI**: `http://localhost:8080` (or `http://localhost:5000`)
- **Interactive Swagger UI**: `http://localhost:8080/swagger`
- **Health Check Probe**: `http://localhost:8080/health`

---

## 🌐 REST API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/jobs` | Search & filter jobs (supports `keyword`, `category`, `minSalary`, `locationType`, `sortBy`, `page`) |
| `GET` | `/api/jobs/{id}` | Get complete job details, requirements, and company profile |
| `GET` | `/api/jobs/categories` | Get category breakdown counts across aggregated sources |
| `POST` | `/api/jobs/alerts` | Subscribe to custom email job alerts |
| `POST` | `/api/jobs/refresh` | Trigger real-time cache refresh across all provider connectors |
| `GET` | `/api/analytics` | Get fintech salary benchmarks, skill demand rankings, and hiring hubs |
| `GET` | `/health` | Container liveness & readiness health probe |

---

## 🔄 GitHub Actions CI/CD Pipeline

The `.github/workflows/cicd.yml` workflow automatically runs on every `push` and `pull_request` to `main` / `master` and on tags (`v*.*.*`):

1. **Stage 1: Build & Test (`build-and-test`)**
   - Sets up .NET 8 SDK and caches NuGet packages.
   - Compiles solution in `Release` mode and executes xUnit tests with code coverage.
   - Uploads TRX test results artifact.
2. **Stage 2: Package Release (`package-and-publish`)**
   - Runs `dotnet publish` to build standalone binaries and uploads package artifacts.
3. **Stage 3: Container Security Scan (`docker-security-scan`)**
   - Builds local container image and scans for vulnerabilities (`CRITICAL, HIGH, MEDIUM`) using **Aqua Security Trivy**.
   - Outputs scan results table and generates SARIF security reports uploaded as artifacts.
4. **Stage 4: Containerize & Push to Docker Hub (`docker-build-and-push`)**
   - Authenticates with Docker Hub using PAT and Username.
   - Builds multi-stage container and pushes tagged images (`latest`, `sha-*`, branch, semver) to Docker Hub.

---

## 🏗️ Terraform Infrastructure Pipeline (`infra.yml`)

The [`.github/workflows/infra.yml`](.github/workflows/infra.yml) workflow automates provisioning and managing AWS ECS Fargate infrastructure with Terraform:

- **AWS ECS Cluster & Fargate Tasks**: Highly available container execution.
- **Application Load Balancer (ALB)**: Public ingress on Port 80 forwarding to container port 8080 with automated `/health` probes.
- **VPC & Subnets**: Multi-AZ public subnets with Internet Gateway and isolated security groups.
- **IAM Roles**: `ecsTaskExecutionRole` with `AmazonECSTaskExecutionRolePolicy` and task roles.
- **CloudWatch Logs**: Centralized container logging (`/ecs/fintech-job-portal`).

### Triggering Terraform in GitHub Actions:
- Go to **Actions > Terraform Infrastructure Provisioning**.
- Click **Run workflow** and select action: `apply`, `plan`, or `destroy`.

---

## 🚀 Continuous Deployment to AWS ECS Fargate (`cd.yml`)

The [`.github/workflows/cd.yml`](.github/workflows/cd.yml) pipeline executes automatically whenever `cicd.yml` successfully builds and pushes a new Docker image on `main`:

1. Downloads the active AWS ECS Task Definition.
2. Injects the newly pushed Docker image tag (`rajnadar/fintech-job-portal:latest` or git SHA).
3. Deploys to the ECS Cluster with zero-downtime rolling updates.
4. Waits for Fargate service stability and prints the live ALB DNS URL.

---

## 🔑 GitHub Secrets Configuration

Add these secrets under **Settings > Secrets and variables > Actions**:

| Secret Name | Description |
|---|---|
| `DOCKERHUB_USERNAME` | Your Docker Hub Username |
| `DOCKERHUB_TOKEN` | Your Docker Hub Personal Access Token (PAT) |
| `AWS_ACCESS_KEY_ID` | AWS IAM Access Key ID for Terraform & ECS |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM Secret Access Key |
| `AWS_REGION` | AWS Region (e.g. `us-east-1` or `eu-west-1`) |

---

## 📄 License
MIT License. Built for fintech innovators and engineers worldwide.