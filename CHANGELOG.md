# Changelog

All notable, unreleased changes to this project will be documented in this file. For the released changes, please visit the [Releases](https://github.com/saleor/saleor/releases) page.

# 3.23.0 [Unreleased]

### Breaking changes

### GraphQL API

### Webhooks

### Other changes

- Add `django-cors-headers` to runtime dependencies to ensure static asset collection works in deployed builds (Render).
- Regenerated `uv.lock` to include the new dependency.
- Add CI workflow `uv-lock-check` and `docs/UV_LOCK.md` to ensure `uv.lock` stays in sync with `pyproject.toml` and document how to regenerate it.

### Deprecations
