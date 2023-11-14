#!/bin/bash

CGO_CFLAGS=-mmacosx-version-min=10.12 bee run

# ./build.sh
# cd ./out 
# if [[ $# == 0 ]]
# then 
#   ./metal -conf=./conf-local.toml
# else 
#   ./metal $@
# fi