FROM node:8.6.0

COPY main.coffee main.coffee
COPY ./lib/connection-factory.coffee lib/connection-factory.coffee
COPY ./lib/discord-events.coffee lib/discord-events.coffee
COPY ./lib/helpers.coffee lib/helpers.coffee
COPY ./lib/rust-events.coffee lib/rust-events.coffee
COPY package.json package.json
USER androgee
RUN npm install

ARG discord_token
ARG rust_ip
ARG rust_port
ARG rust_password
ARG minecraft_ip
ARG minecraft_port
ARG minecraft_password

ENV DISCORD_TOKEN=${discord_token}
ENV RUST_IP=${rust_ip}
ENV RUST_PORT=${rust_port}
ENV RUST_PASSWORD=${rust_password}
ENV MINECRAFT_IP=${minecraft_ip}
ENV MINECRAFT_PORT=${minecraft_port}
ENV MINECRAFT_PASSWORD=${minecraft_password}

CMD ["npm", "start"]
