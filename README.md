# Starter project for: TypeORM + OracleDB

## Setup single instance OracleDB for development

These steps are specific for OracleDB version 11.2. For other versions, the steps should be the same but the specific
commands might differ.

### 1. Checkout submodules

```shell
git submodule update --init
```

### 2. Download OracleDB binary

```shell
curl http://download.xskernel.org/soft/linux-rpm/oracle-xe-11.2.0-1.0.x86_64.rpm.zip \
  --output ./oracle-docker-images/OracleDatabase/SingleInstance/dockerfiles/11.2.0.2/oracle-xe-11.2.0-1.0.x86_64.rpm.zip
```

### 3. Build OracleDB docker image

```shell
./oracle-docker-images/OracleDatabase/SingleInstance/dockerfiles/buildContainerImage.sh -x -v 11.2.0.2
```

After this step, you should get an image named `oracle/database:11.2.0.2-xe` on your machine.

Reference: https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/README.md#building-oracle-database-container-images

### 4. Compose

Your docker environment should be ready before this step.

```shell
docker-compose up -d --build
```

Verify that your `server` worked and exited without any error.

```shell
docker-compose logs server
```

The logs should be similar to these:

```shell
Inserting a new user into the database...
Saved a new user with id: 54e45c7b-6c17-469e-9a44-390764dc2d7a
Loading users from the database...
Loaded users:  [
  User {
    id: '2fdb132a-c146-433e-a012-9ddb7c037be0',
    firstName: 'Timber',
    lastName: 'Saw',
    age: 25
  },
]
Here you can setup and run express/koa/any other framework.
```

## How to start a Nodejs server on your host machine connects to dockerized OracleDB

### 1. Install Oracle Instant Client (OIC)

Be careful, The latest OIC which can work with OracleDB 11.2 is OIC 19.

#### For windows:

1. Download https://download.oracle.com/otn_software/nt/instantclient/1911000/instantclient-basic-windows.x64-19.11.0.0.0dbru.zip
2. Unzip to `C:\oracle\instantclient_19_11`
3. Add `C:\oracle\instantclient_19_11` to `PATH` at system environment variables.

#### For Linux x86_64:

Follow: https://oracle.github.io/node-oracledb/INSTALL.html#-321-node-oracledb-installation-on-linux-x86_64-with-instant-client-zip-files

Full reference: https://oracle.github.io/node-oracledb/INSTALL.html#quickstart

### 2. Start Nodejs server

Update [ormconfig.json](./ormconfig.json#L3), change `host` field from `oracledb` to `localhost`.

```
{
...
  "host": "localhost",
...
}
```

Make sure your Nodejs environment has been correctly setup.

```shell
yarn install
./node_modules/.bin/ts-node src/index.ts
```
