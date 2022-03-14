#!/bin/sh

echo "step1: build and run frontend "
docker build --no-cache -t frontend:latest -f ./frontend/Dockerfile /frontend
docker rm --force frontend || true && docker run -d --name frontend -p 80:80 -P frontend:latest

echo "step2: build and run backend"
cd lib_catalog && docker-compose up -d --build --force-recreate --no-deps && cd ..

echo "clean"
cd lib_catalog && docker-compose down && cd .. && docker rm --force frontend || true

echo "step3: build and run"
docker-compose up -d --build --force-recreate --no-deps