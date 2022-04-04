#!/bin/sh

ARCHES_PROJECT=${ARCHES_PROJECT} docker-compose build
docker build --build-arg ARCHES_PROJECT=$ARCHES_PROJECT --build-arg DJANGO_DUMMY_SECRET_KEY='c7ky-mc6vdnv+avp0r@(a)8y^51ex=25nogq@+q5*mxwdi' --build-arg VERSION=latest -f Dockerfile.static -t arches_${ARCHES_PROJECT}_static:latest .
