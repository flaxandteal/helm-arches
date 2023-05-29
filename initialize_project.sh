#!/bin/sh

SCRIPT_DIR=$( dirname "$0" )

if [ -z "$ARCHES_PROJECT" ]
then
  echo "The \$ARCHES_PROJECT variable must be set"
  exit 1
fi

if [ -z "$ARCHES_ROOT" ]
then
  echo "The \$ARCHES_ROOT variable must be set"
  exit 1
fi

if ! [ -d "$ARCHES_PROJECT" ] || ! [ -f "$ARCHES_PROJECT/manage.py" ]
then
  echo "This should be run from your ARCHES_PROJECT root," \
    "the directory above manage.py"
  exit 2
fi

if ! [ -d "$ARCHES_ROOT" ] || ! grep -q 'name="arches"' $ARCHES_ROOT/setup.py
then
  echo "Your ARCHES_ROOT path, $ARCHES_ROOT, does not seem to contain" \
    "the archesproject/arches source tree"
  exit 3
fi

if ! [ -d "$SCRIPT_DIR/supplementary" ]
then
  echo "Cannot find supplementary files, have you moved the script" \
    "out of helm-arches? Your command should look like:" \
    "ARCHES_PROJECT=myproject ../helm-arches/initialize_project.sh"
  exit 4
fi

export ARCHES_BASE=arches_${ARCHES_PROJECT}_base

cp $SCRIPT_DIR/supplementary/* .
(cd $ARCHES_ROOT; docker build . -t $ARCHES_BASE)

mkdir -p ./docker
touch ./docker/env_file.env
touch $ARCHES_PROJECT/requirements.txt

if ! grep -q 'from arches\.settings_docker import \*' $ARCHES_PROJECT/$ARCHES_PROJECT/settings.py
then
  echo "\nfrom arches.settings_docker import *\n" >> $ARCHES_PROJECT/$ARCHES_PROJECT/settings.py
fi

# Build dynamic (development) images
docker-compose -f docker-compose.yml build

# Build deployable images
STATIC_URL="http://localhost:8080/" docker-compose -f docker-compose-static.yml build
