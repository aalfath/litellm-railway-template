# Changelog

Each entry is one version of this Railway template. Breaking changes come first.
Railway shows deployers an "update available" notice when `main` changes; read the entry before you apply it.

## 2026-11-16: Deploy on Railway button

- README: add the Deploy on Railway button for the published template `litellm-2`. No change to the app or its configuration.

## 2026-11-16: LiteLLM v1.109.1 (first release)

- LiteLLM proxy `ghcr.io/berriai/litellm-database:v1.109.1` (digest `sha256:932c5444…6986`), built from this repo.
- Railway Postgres for keys, users, teams, spend logs and models added in the Admin UI.
- Generated master key, salt key and Admin UI password; no default passwords.
- Health check: `/health/liveliness`.
