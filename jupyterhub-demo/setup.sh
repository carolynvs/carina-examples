#!/bin/sh
set -e

echo "Performing one-time setup for our JuputerHub instance..."

# Create a data volume container to store persistant data
echo "Creating the jupyterhub-data container to store persistant data for your JupyterHub instance"
docker run \
  --name jupyterhub-data \
  --volume /etc/letsencrypt \
  --volume /etc/jupyterhub \
  --volume /etc/certs \
  --entrypoint /bin/mkdir \
  quay.io/letsencrypt/letsencrypt \
  -p /etc/letsencrypt/webrootauth/

# Generate a Let's Encrypt certificate for JupyterHub
echo "Checking for a Let's Encrypt certificate..."
if [[ $JUPYTERHUB_DOMAIN ]]; then
  echo "Generating a Let's Encrypt certificate for $JUPYTERHUB_DOMAIN"
  source ~/.dvm/dvm.sh
  dvm use

  docker run \
    --rm \
    --volumes-from jupyterhub-data \
    --publish 443:443 \
    --publish 80:80 \
    quay.io/letsencrypt/letsencrypt certonly \
    --server https://acme-staging.api.letsencrypt.org/directory \
    --domain $JUPYTERHUB_DOMAIN \
    --authenticator standalone \
    --email $LETSENCRYPT_EMAIL \
    --agree-tos

  cp /etc/letsencrypt/live/$JUPYTERHUB_DOMAIN/privkey.pem /etc/certs/jupyterhub.key
  cp /etc/letsencrypt/live/$JUPYTERHUB_DOMAIN/fullchain.pem /etc/certs/jupyterhub.cert
fi

# Print out the IP address where the hub will run
echo "All done! If you are running JupyterHub with a domain name, update your DNS now to point to the IP address below:"
docker run --rm --net=host racknet/ip service ipv4
