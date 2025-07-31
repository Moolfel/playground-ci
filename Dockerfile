FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    curl git htop tree jq neofetch \
    python3 python3-pip python3-venv \
    build-essential ca-certificates gnupg lsb-release

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt install -y nodejs

RUN python3 -m venv /opt/wrdn-env && \
    /opt/wrdn-env/bin/pip install django && \
    mkdir -p /opt/wrdn-apps/djangodemoapp && \
    /opt/wrdn-env/bin/django-admin startproject djangodemoapp /opt/wrdn-apps/djangodemoapp

RUN mkdir -p /opt/wrdn-apps/nodeapp && \
    echo 'console.log(" Node.js App for a client!")' > /opt/wrdn-apps/nodeapp/index.js && \
    echo '{ "name": "nodeapp", "version": "1.0.0", "main": "index.js", "scripts": { "start": "node index.js" } }' > /opt/wrdn-apps/nodeapp/package.json

RUN echo "<<<------ Custom W___n Ubuntu CI Image with Django + Node.js Apps --->>>" > /etc/motd && \
    echo "<<<------ Django app: /opt/wrdn-apps/djangodemoapp --->>>" >> /etc/motd && \
    echo "<<<------ Node.js app: /opt/wrdn-apps/nodeapp--->>>" >> /etc/motd && \
    echo "<<<------Python WRDN Virtual Env: /opt/wrdn-env (auto-activated)--->>>" >> /etc/motd

RUN echo "source /opt/wrdn-env/bin/activate" >> ~/.bashrc

WORKDIR /opt/wrdn-apps/nodeapp

CMD ["bash"]
