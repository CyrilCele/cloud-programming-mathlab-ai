# Quick Start

## 1. Clone the Repository

```bash
git clone <repository-url>
cd <repository-folder>
```

---

## 2. Configure AWS

```bash
aws configure
```

Verify your credentials.

```bash
aws sts get-caller-identity
```

---

## 3. Verify Prerequisites

```bash
make prerequisites
```

---

## 4. Deploy Infrastructure

```bash
make deploy
```

---

## 5. Verify Deployment

```bash
make verify
```

---

## 6. Destroy Infrastructure

```bash
make destroy
```

---

## Summary

The project is fully automated. A new developer or lecturer can deploy, verify, and remove the infrastructure using only the commands above with minimal manual configuration.
