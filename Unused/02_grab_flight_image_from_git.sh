#!/bin/bash

# Grab from Git repo
git fetch; git pull

# Build the Docker file (SKIP THIS, it's already built!)
docker build -t xgboost-python:1.0 .

# Then you run it
docker run -p 9110:8080 flight-python:1.0

# Check that it's running!
curl localhost:9100