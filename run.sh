#/bin/bash

docker build --build-arg rust_ip=$RUST_IP --build-arg rust_port=$RUST_PORT --build-arg rust_password=$RUST_PASSWORD --build-arg discord_token=$DISCORD_TOKEN . -t androgee
# docker run 
