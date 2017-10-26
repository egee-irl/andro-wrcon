#TODO SED envvars
FROM node:8.6.0

ENV RUST_IP='_RUSTIP_'
ENV RUST_PORT='_RUSTPORT_'
ENV RUST_PASSWORD='_RUSTPASSWORD_'

RUN adduser androgee
ADD . /home/androgee
RUN chown -R androgee /home/androgee

RUN npm install -g coffeescript
USER androgee
WORKDIR /home/androgee
RUN npm install

CMD ["coffee", "main.coffee"]
