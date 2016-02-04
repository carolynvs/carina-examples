FROM jupyter/jupyterhub:0.4.1

# Install Docker Spawner
WORKDIR /srv/
RUN git clone --depth 1 https://github.com/jupyter/dockerspawner.git
WORKDIR /srv/dockerspawner
RUN pip install -r requirements.txt && python setup.py install

# Install Jupyter OAuthenticator
RUN pip install git+https://github.com/jupyter/oauthenticator.git

# Copy our whitelisted users
ADD userlist /srv/jupyterhub/

# Install Jupyter Client (Not sure why this needs to be installed explicitly when betatim didn't need to? Where am I missing the magic?)
RUN pip install git+https://github.com/jupyter/jupyter_client.git
