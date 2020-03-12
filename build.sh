#!/bin/bash

BRANCH=$(git symbolic-ref --short HEAD)

if [ $BRANCH == "master" ]; then
    BRANCH="latest"
fi

docker build -t "nextgensolution/laravel:${BRANCH}" .
