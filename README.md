# Arches Unofficial Chart Repository [UNOFFICIAL]

## v0.0.10

### Getting Started

The steps below have been tested with a fresh project, but should in principle work (or be adaptable) to retrofit an existing project.

#### docker-compose

While the upstream Arches project has a docker-compose.yml, this uses a minor variation to simplify maintaining out-of-tree projects and pushing them to Kubernetes.

You will need a checked out version of the Arches codebase (to reach the init-unix.sql
script) at `LOCATION-OF-ARCHES-CODE-BASE`. We use `MYPROJECT` as your _snake-cased_ project
name. For example: `my_project` or `arches_topaz`. If `ARCHES_ROOT` is not defined, the
in-project `init-unix.sql` will be used from `ARCHES_PROJECT/ARCHES_PROJECT/media/packages/arches`
but this may be out of step with your base image if it is custom-built from ARCHES_ROOT.

1. Follow usual project creation guide, up to and including `arches-project create MYPROJECT`
2. From the same folder, run `ARCHES_PROJECT=MYPROJECT ARCHES_ROOT=LOCATION-OF-ARCHES-CODE-BASE PATH-TO-THIS-REPO/initialize_project.sh` (e.g. `ARCHES_PROJECT=myproject ARCHES_ROOT=../arches ../helm-arches/initialize_project.sh`)
4. Run `ARCHES_PROJECT=MYPROJECT ARCHES_ROOT=LOCATION-OF-ARCHES-CODE-BASE docker-compose up` (e.g. `ARCHES_PROJECT=myproject ARCHES_ROOT=../arches docker-compose up`)

*If you have issues with the script, you can use the following manual steps:*
1. Follow usual project creation guide, up to and including `arches-project create MYPROJECT`
2. Copy supplementary/* into your project folder. As well as providing Dockerfiles, this slightly adapts default entrypoint.sh behaviour for static files and worker processes
3. In your _arches_ codebase, run `docker build . -t arches`
4. Add the line `from arches.settings_docker import *` to the _end_ of `MYPROJECT/settings.py`
5. Run `ARCHES_PROJECT=MYPROJECT docker-compose build`
6. (Optional) Run `ARCHES_PROJECT=MYPROJECT STATIC_URL=http://localhost:8080 docker-compose -f docker-compose-static.yml build`

You should now have a live-updating Arches project running in Docker, with default login credentials at `http://localhost:8000`. The last step builds static images which can be used for CDN-style serving.


### Minikube

After launching minikube, go to the project root (one directory above manage.py). This assumes that you have run the steps above.

(note that you may need `minikube addons enable ingress` and ensure minikube.local points to your ingress IP)

1. Link minikube to host docker: `eval $(minikube docker-env)`
2. Re-run the docker-compose build: `ARCHES_PROJECT=MYPROJECT STATIC_URL=http://minikube.local/media/ docker-compose build`
3. `ARCHES_PROJECT=MYPROJECT STATIC_URL=http://minikube.local/media/ docker-compose -f docker-compose-static.yml build`
4. cd to this repository directory
5. `(cd archesproject && helm dependencies update)`
6. Update build/values-local.yaml
7. `helm install $ARCHES_PROJECT ./archesproject --values build/values-local.yaml --set image.repository=arches_${ARCHES_PROJECT}_static_py --set imageStatic.repository=arches_${ARCHES_PROJECT}_static --set archesProject=$ARCHES_PROJECT`

