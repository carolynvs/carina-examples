FROM jupyter/jupyterhub:0.5.0

# Install jupyterhub-carina plugin
ADD requirements.txt /tmp
RUN pip install -U -r /tmp/requirements.txt

# Install curl
RUN apt-get update && \
    apt-get install -y curl

# Fix missing CA certs
# Regression: https://bugs.launchpad.net/debian/+source/ca-certificates/+bug/1551615
# Workaround: https://github.com/4commerce-technologies-AG/meteor/issues/37#issuecomment-184310053
RUN cd /tmp && \
    curl -L -O "https://archive.raspbian.org/raspbian/pool/main/c/ca-certificates/ca-certificates_20130119+deb7u1_all.deb" && \
    dpkg -P --force-all ca-certificates && \
    dpkg -i /tmp/ca-certificates_20130119+deb7u1_all.deb

# TODO: Can we detect this somehow?
ENV DOCKER_VERSION 1.10.3

# Install DVM
RUN sh -c "curl -sL https://download.getcarina.com/dvm/latest/install.sh | sh"

# Install Docker client
RUN bash -c "source /root/.dvm/dvm.sh && dvm install"

# On startup, make SSL certificates, if needed, then start JupyterHub
COPY run.sh /
CMD ["/run.sh"]
