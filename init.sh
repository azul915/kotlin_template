#!/bin/bash

echo -e 'docker-compose down -v'
docker-compose down -v

echo -e 'docker-compose build --no-cache'
docker-compose build --no-cache

echo -e 'docker-compose up -d'
docker-compose up -d

echo -e 'docker-compose exec jdk /bin/bash'
docker-compose exec jdk /bin/bash
