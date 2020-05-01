FROM docker.io/python:3.7-slim-buster

ENV DEBIAN_FRONTEND=noninteractive
ENV ELECTRUMX_VERSION=1.14.0

RUN apt-get update; \
    apt-get install --no-install-recommends --no-install-suggests -y git; \
    pip install plyvel; \
    mkdir /build; cd /build; \
    git clone -b ${ELECTRUMX_VERSION} https://github.com/kyuupichan/electrumx.git; \
    cd electrumx; \
    python setup.py install; \
    apt-get purge --auto-remove git; \
    apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 50001 50002

VOLUME /srv

ENTRYPOINT ["electrumx_server"]
