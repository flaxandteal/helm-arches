FROM arches

RUN useradd arches
RUN chgrp arches ../entrypoint.sh && chmod g+rx ../entrypoint.sh
ARG ARCHES_PROJECT
ENV ARCHES_PROJECT $ARCHES_PROJECT
COPY ${ARCHES_PROJECT} entrypoint.sh ${WEB_ROOT}/${ARCHES_PROJECT}/
COPY settings_docker.py ${WEB_ROOT}/arches/arches/
WORKDIR ${WEB_ROOT}/${ARCHES_PROJECT}/${ARCHES_PROJECT}
RUN mkdir -p /static_root && chown -R arches /static_root
RUN yarn install
WORKDIR ${WEB_ROOT}/${ARCHES_PROJECT}
ENTRYPOINT ./entrypoint.sh
USER 1000
