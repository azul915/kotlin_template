#!/bin/bash

current=$(cd $(dirname $0) && pwd)
cd $current

mkdir ./kotlin

cat <<'EOF' > kt-native.dockerfile
FROM openjdk:16-slim AS dev
ENV SRC /usr/local/kotlin
ENV GRADLE_VERSION 6.7.1
ENV PATH /usr/local/gradle-$GRADLE_VERSION/bin:$PATH

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip && \
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip -d /usr/local && \
    rm gradle-${GRADLE_VERSION}-bin.zip && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
EOF
mkdir ./docker && mv kt-native.dockerfile ./docker/

cat <<'EOF' > docker-compose.yml
version: "3.7"
services:
  jdk:
    build:
      context: .
      dockerfile: ./docker/kt-native.dockerfile
      target: dev
    working_dir: /usr/local
    tty: true
    volumes:
      - ./kotlin:/usr/local/kotlin
      - ./build.sh:/usr/local/build.sh
EOF

echo -e 'docker-compose build --no-cache'
docker-compose build --no-cache

echo -e 'docker-compose up -d'
docker-compose up -d