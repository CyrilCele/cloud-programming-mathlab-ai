# Quick Start

This guide provides the minimum steps required to deploy the infrastructure.

---

## 1. Clone the repository

```bash
git clone <repository-url>
cd <repository-folder>
```

---

## 2. Install prerequisites

```bash
bash scripts/install.sh
```

---

## 3. Validate the local environment

```bash
bash scripts/prerequisites.sh
```

---

## 4. Configure AWS credentials

```bash
aws configure
```

Verify the active identity:

```bash
aws sts get-caller-identity
```

---

## 5. Deploy the infrastructure

```bash
bash scripts/deploy.sh
```

---

## 6. Verify the deployment

```bash
bash scripts/verify.sh
```

---

## 7. Run quality checks

```bash
bash scripts/quality.sh
```

---

## 8. Destroy the infrastructure

```bash
bash scripts/destroy.sh
```
