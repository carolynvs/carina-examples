#!/bin/bash
set -e

# Generate a persistant cookie for JupyterHub
echo "Checking for a JupyterHub cookie secret..."
if [ ! -f /etc/jupyterhub/cookie_secret ]; then
    echo "Initializing a new cookie secret"
    openssl rand -base64 2048 > /etc/jupyterhub/cookie_secret
fi

# Generate a self-signed certificate for JupyterHub
echo "Checking for a self-signed certificate..."
if [[ ! -f /etc/certs/jupyterhub.key ]]; then
  echo "Generating a self-signed certificate"
  openssl req -x509 -newkey rsa:2048 -days 365 -nodes -batch \
    -keyout /etc/certs/jupyterhub.key \
    -out /etc/certs/jupyterhub.cert
fi

echo "Staring JupyterHub..."
exec jupyterhub -f /srv/jupyterhub/jupyterhub_config.py
