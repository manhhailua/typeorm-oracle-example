# Copyright (c) 2021 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
FROM oraclelinux:8-slim

COPY nodejs.module /etc/dnf/modules.d/nodejs.module

RUN microdnf install oracle-instantclient-release-el8 oraclelinux-developer-release-el8 && \
    microdnf install libaio oracle-instantclient-basic node-oracledb-node14 && \
    microdnf clean all

ENV NODE_PATH=/usr/local/lib/node_modules/

WORKDIR /app

COPY ./package.json ./package.json
COPY ./yarn.lock ./yarn.lock

RUN npm install -g yarn && yarn install

COPY ./src ./src
COPY ./ormconfig.json ./ormconfig.json
COPY ./tsconfig.json ./tsconfig.json

CMD ["/app/node_modules/.bin/ts-node", "src/index.ts"]
