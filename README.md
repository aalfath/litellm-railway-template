[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/litellm-2?utm_medium=integration&utm_source=button&utm_campaign=litellm)

# LiteLLM on Railway

A Railway template for [LiteLLM](https://github.com/BerriAI/litellm), the open-source AI gateway: one OpenAI-compatible API in front of 100+ model providers, with virtual keys, budgets, rate limits, spend tracking and an Admin UI.

## What it deploys

| Service | Source | Notes |
|---|---|---|
| `LiteLLM` | this repo (`Dockerfile`) | `ghcr.io/berriai/litellm-database:v1.109.1`, pinned by digest. Public domain on port 4000. Health check `/health/liveliness` |
| `Postgres` | Railway Postgres | Stores keys, users, teams, budgets, spend logs and models added in the UI. Data on a volume |

The proxy itself keeps no files: everything lives in Postgres.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `LITELLM_MASTER_KEY` | generated, `sk-…` | Admin API key. Use it as `Authorization: Bearer …` to create virtual keys and call models |
| `LITELLM_SALT_KEY` | generated, `sk-…` | Encrypts provider API keys stored in the database. **Never change it after the first deploy**, or saved provider keys can't be decrypted |
| `UI_PASSWORD` | generated | Password for the Admin UI at `/ui` (username `admin`) |
| `DATABASE_URL` | `${{Postgres.DATABASE_URL}}` | Postgres connection |
| `PORT` | `4000` | Port the proxy listens on |

Baked into the image: `STORE_MODEL_IN_DB=True` (models added in the UI are saved) and `UI_USERNAME=admin`. Override either by adding the variable on the service.

## After deploying

1. Open `https://YOUR-DOMAIN/ui` and sign in as `admin` with the `UI_PASSWORD` value from the service's Variables tab.
2. Add a model under **Models + Endpoints** with your provider's API key (OpenAI, Anthropic, Azure, Bedrock, Ollama and many more).
3. Create a virtual key under **Virtual Keys**, then point any OpenAI SDK at `https://YOUR-DOMAIN` with that key.

You can also manage everything over the API with the master key, for example `curl https://YOUR-DOMAIN/key/generate -H "Authorization: Bearer $LITELLM_MASTER_KEY"`.

## Updates

New LiteLLM versions come as a change to the `FROM` line in `Dockerfile`, with a `CHANGELOG.md` entry. When it is merged to `main`, Railway shows deployers of this template an "update available" notice, and you choose when to apply it. Database migrations run automatically at start-up.
