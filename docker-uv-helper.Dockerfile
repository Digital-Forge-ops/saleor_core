FROM python:3.12
COPY --from=ghcr.io/astral-sh/uv:0.8 /uv /uvx /bin/
WORKDIR /app
ENTRYPOINT ["/bin/sh","-c"]
