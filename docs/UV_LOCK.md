UV lockfile
===============

This repository uses `uv` (astral/uv) to manage Python dependencies. The lockfile `uv.lock` must be kept in sync with `pyproject.toml`.

Why keep `uv.lock` in sync
- `uv sync --locked` is used in the Docker build to ensure reproducible installs.
- If `pyproject.toml` changes, you must regenerate `uv.lock` using `uv lock` and commit it. CI enforces this with a check on PRs.

Regenerate `uv.lock` locally (option A) — install `uv` in your venv

1. Activate your virtualenv:

```powershell
& .\.venv\Scripts\Activate.ps1
```

2. Install uv in the venv:

```powershell
python -m pip install 'uv==0.8.*'
```

3. Run the lock command:

```powershell
uv lock
```

4. Verify, commit and push:

```powershell
Select-String -Path uv.lock -Pattern "django-cors-headers"
git add uv.lock
git commit -m "Regenerate uv.lock"
git push
```

Regenerate `uv.lock` with Docker (option B) — no local install required

1. Create a helper Dockerfile (one-liner):

```powershell
@'
FROM python:3.12
COPY --from=ghcr.io/astral-sh/uv:0.8 /uv /uvx /bin/
WORKDIR /app
ENTRYPOINT ["/bin/sh","-c"]
'@ > docker-uv-helper.Dockerfile
```

2. Build the helper image:

```powershell
docker build -f docker-uv-helper.Dockerfile -t uv-helper:0.8 .
```

3. Run `uv lock` inside the helper image (this writes `uv.lock` into your repo):

```powershell
docker run --rm -v "${PWD}:/app" -w /app uv-helper:0.8 /bin/uv lock
```

4. Verify, commit and push (same as above):

```powershell
Select-String -Path uv.lock -Pattern "django-cors-headers"
git add uv.lock
git commit -m "Regenerate uv.lock"
git push
```

Troubleshooting
- If Docker build fails with "invalid file request" or similar, you may be working inside OneDrive and some files are placeholders. Either set the repo to "Always keep on this device" in OneDrive or clone the repo to a non-OneDrive location (e.g., `C:\projects`).
- If `uv lock` errors, paste the output into an issue or contact a maintainer.
