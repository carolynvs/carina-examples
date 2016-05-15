#!/bin/sh
set -e

# 1. REQUIRED: Comma-separated list of Carina usernames to be JupyterHub administrators
export JUPYTERHUB_ADMINS=carolynvs

# 2. REQUIRED: Set this with your Carina OAUTH Application Id and Secret
# https://getcarina.com/docs/reference/oauth-integration/#register-your-application
export OAUTH_CLIENT_ID=781eb7d8da90dbb9a08260f5c2784896d1208c451db4011096eacaa09ab618fe
export OAUTH_CLIENT_SECRET=db48dd9d906d14974743c619d535b1a7f5d3acfaffb085eb8a01b87b4d5ab47f

# 3. OPTIONAL: Set your domain name and the email address which owns the domain
# If you leave these blank, you get a self signed certificate instead
export JUPYTERHUB_DOMAIN=jupyterhub.carolynvs.com
export LETSENCRYPT_EMAIL=me@carolynvanslyck.com

# Run JupyterHub
docker run --name jupyterhub \
  --detach \
  --publish 80:8081 \
  --volumes-from jupyterhub-data \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  -e JUPYTERHUB_DOMAIN=$JUPYTERHUB_DOMAIN \
  -e LETSENCRYPT_EMAIL=$JUPYTERHUB_DOMAIN \
  -e OAUTH_CLIENT_ID=$OAUTH_CLIENT_ID \
  -e OAUTH_CLIENT_SECRET=$OAUTH_CLIENT_SECRET \
  jupyterhub-carina
