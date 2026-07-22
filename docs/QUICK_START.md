# Quick Start

Clone the repository.

```bash
git clone <repository-url>
cd <repository-folder>
```

Configure AWS credentials.

```bash
aws configure
aws sts get-caller-identity
```

Deploy the infrastructure.

```bash
bash scripts/deploy.sh
```

Verify the deployment.

```bash
bash scripts/verify.sh
```
