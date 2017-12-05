#TODO SED envvars
FROM node:8.6.0

RUN adduser androgee
WORKDIR /home/androgee
COPY main.coffee main.coffee
COPY ./lib/discord-events.coffee lib/discord-events.coffee
COPY ./lib/helpers.coffee lib/helpers.coffee
COPY ./lib/rust-events.coffee lib/rust-events.coffee
COPY package.json package.json
RUN chown -R androgee:androgee /home/androgee
USER androgee
RUN npm install

ARG discord_token
ARG rust_ip
ARG rust_port
ARG rust_password

ENV DISCORD_TOKEN=${discord_token}
ENV RUST_IP=${rust_ip}
ENV RUST_PORT={$rust_port}
ENV RUST_PASSWORD=${rust_password}

CMD ["npm", "start"]
