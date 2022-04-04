# Arches Unofficial Chart Repository [UNOFFICIAL]

## v0.0.2

### Getting Started

#### docker-compose

While the upstream Arches project has a docker-compose.yml, this uses a minor variation to simplify maintaining out-of-tree projects and pushing them to Kubernetes.

You will need a checked out version of the Arches codebase (to reach the init-unix.sql
script) at `LOCATION-OF-ARCHES-CODE-BASE`. We use `MYPROJECT` as your _snake-cased_ project
name. For example: `my_project` or `arches_topaz`.

1. Follow usual project creation guide, up to and including `arches-project create MYPROJECT`
2. From the same folder, run `ARCHES_PROJECT=MYPROJECT ARCHES_ROOT=LOCATION-OF-ARCHES-CODE-BASE PATH-TO-THIS-REPO/initialize_project.sh` (e.g. `ARCHES_PROJECT=myproject ARCHES_ROOT=../arches ../helm-arches/initialize_project.sh`)
4. Run `ARCHES_PROJECT=MYPROJECT ARCHES_ROOT=LOCATION-OF-ARCHES-CODE-BASE docker-compose up` (e.g. `ARCHES_PROJECT=myproject ARCHES_ROOT=../arches docker-compose up`)

*If you have issues with the script, you can use the following manual steps:*
1. Follow usual project creation guide, up to and including `arches-project create MYPROJECT`
2. Copy supplementary/* into your project folder. As well as providing Dockerfiles, this slightly adapts default entrypoint.sh behaviour for static files and worker processes
3. In your _arches_ codebase, run `docker build . -t arches`
4. Add the line `from arches.settings_docker import *` to the _end_ of `MYPROJECT/settings.py`
5. Run `ARCHES_PROJECT=MYPROJECT ARCHES_ROOT=LOCATION-OF-ARCHES-CODE-BASE docker-compose up`

You should now have a live-updating Arches project running in Docker, with default login credentials at `http://localhost:8000`


### Minikube

1. `eval $(minikube docker-env)`
2. Build dynamic and static containers
3. Update build/values-local.yaml
4. `helm install arches ./archesproject --values build/values-local.yaml`

