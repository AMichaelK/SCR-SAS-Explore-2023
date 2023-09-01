#!/bin/bash

# Pull from Registry
docker pull registry.unx.sas.com/mmtest/flight_sklearn@sha256:e6489ad1cb61eb4bb7029a9069543aaa5df0869e4e20dadc0781bdf493f5a37f

# Tag for a more friendly name (grab the image ID)
docker tag 297ab202464eaf520e027a8ff43f7e13798ec923e8a761edf711d542f3cdb6e1 flight-python:1.0

# Then you run it (SKIP THIS; it's already running)
docker run -p 9100:8080 flight-python:1.0

# Check that it's running!
curl localhost:9100