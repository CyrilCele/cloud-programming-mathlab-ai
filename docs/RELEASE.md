# Release Process

## Versioning

The project follows Semantic Versioning.

MAJOR.MINOR.PATCH

Example:

1.0.0

---

## Release Checklist

- Documentation updated
- CHANGELOG updated
- Tests passing
- Terraform validated
- Security scans completed
- GitHub Actions passing

---

## Release Steps

1. Commit all changes.
2. Push to main.
3. Create a version tag.
4. Publish GitHub Release.
5. Archive release artifacts.

---

## Release Commands

```bash
git tag -a v1.0.0 -m "Production Release"

git push origin main

git push origin v1.0.0
```
