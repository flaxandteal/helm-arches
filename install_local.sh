#!/bin/sh

ARCHES_PROJECT_KEBAB=$(echo $ARCHES_PROJECT | tr '_' '-')

helm upgrade --install arches-$ARCHES_PROJECT_KEBAB \
  ./archesproject --values build/values-local.yaml \
  --set image.repository="arches_${ARCHES_PROJECT}" \
  --set imageStatic.repository="arches_${ARCHES_PROJECT}_static" \
  --set archesProject=$ARCHES_PROJECT
