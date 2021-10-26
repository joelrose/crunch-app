#!/bin/sh

mkdir swaggers

cd swaggers

curl -O https://localhost:5001/swagger/v1/swagger.json

rm -R ../lib/swagger

flutter pub run build_runner build

rm -R ../swaggers