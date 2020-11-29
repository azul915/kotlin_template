#!/bin/bash

current=$(cd $(dirname $0) && pwd)
cd $current

echo -e 'Cleaning...'
rm -rf src/*

echo -e 'docker-compose down -v'
docker-compose down -v

echo -e 'docker-compose build --no-cache'
docker-compose build --no-cache

echo -e 'docker-compose up -d'
docker-compose up -d

echo -e 'gradle init'
docker-compose exec jdk /bin/sh -c 'cd /usr/local/src && \
gradle init --dsl=kotlin --package=sandbox --project-name=sandbox --type=kotlin-application'

echo -e 'gradlew run'
docker-compose exec jdk /bin/sh -c '/usr/local/src/gradlew run'