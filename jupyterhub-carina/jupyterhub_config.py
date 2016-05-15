import os

# Load environment variables
domain = os.getenv("JUPYTERHUB_DOMAIN")
admin_user = os.getenv("CARINA_USERNAME")

c = get_config()

# Configure JupyterHub to authenticate against Carina
c.JupyterHub.authenticator_class = "jupyterhub_carina.CarinaAuthenticator"
c.CarinaAuthenticator.admin_users = [admin_user]
c.CarinaAuthenticator.oauth_callback_url = "https://{}/hub/oauth_callback".format(domain)

# Configure JupyterHub to spawn user servers on Carina
c.JupyterHub.hub_ip = "0.0.0.0"
c.JupyterHub.spawner_class = "jupyterhub_carina.CarinaSpawner"
c.CarinaSpawner.hub_ip_connect = domain

# Configure SSL certificate
c.JupyterHub.ssl_key = "/etc/certs/jupyterhub.key"
c.JupyterHub.ssl_cert = "/etc/certs/jupyterhub.cert"
