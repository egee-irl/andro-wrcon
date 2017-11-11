#!/bin/bash

sed -i s/_REDIS_/$REDIS/ dockerfile
sed -i s/_RUSTIP_/$RUST_IP/ dockerfile
sed -i s/_RUSTPORT_/$DISCORD_TOKEN/ dockerfile
sed -i s/_RUSTPASSWORD_/$RUST_PASSWORD/ dockerfile
