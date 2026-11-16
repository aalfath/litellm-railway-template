# LiteLLM proxy (AI gateway) for Railway.
# Official image with Prisma for the Postgres database, pinned by version and digest.
FROM ghcr.io/berriai/litellm-database:v1.109.1@sha256:932c54440654f8f8466a85887612d95dcfb04ae2fc01257844332f4bf3b96986

# Fixed settings, baked in so the template only asks for what it must:
# - PORT: the proxy reads it (click envvar). Railway's domain targets 4000.
# - STORE_MODEL_IN_DB: models added in the Admin UI are saved in Postgres.
# - UI_USERNAME: Admin UI login name; the password is the UI_PASSWORD variable.
ENV PORT=4000 \
    STORE_MODEL_IN_DB=True \
    UI_USERNAME=admin

EXPOSE 4000

# The upstream image runs `docker/prod_entrypoint.sh --port 4000`, which ignores PORT.
# Clear CMD so the port comes from the PORT variable instead.
ENTRYPOINT ["docker/prod_entrypoint.sh"]
CMD []
