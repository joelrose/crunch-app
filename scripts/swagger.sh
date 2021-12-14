#!/bin/sh

cd ../core/hermes_api

curl http://localhost:5000/swagger/v1/swagger.json --output lib/swagger.json

rm -R lib/swagger_generated_code

flutter pub run build_runner build

rm lib/swagger.json
