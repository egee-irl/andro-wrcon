#TODO SED envvars
FROM node:8.6.0

ARG discord_token=_changeme_
ARG rust_ip=_changeme_
ARG rust_port=28016
ARG rust_password=_changeme_

ENV DISCORD_TOKEN=${discord_token}
ENV RUST_IP=${rust_ip}
ENV RUST_PORT=$rust_port
ENV RUST_PASSWORD=${rust_password}

WORKDIR /
ADD . /
RUN npm install

CMD ["npm", "start"]
