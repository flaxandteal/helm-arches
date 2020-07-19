FROM getty/arches:5.0

ENV WEB_ROOT=/web_root

RUN mv ${ARCHES_ROOT}/arches/settings_local.py ${ARCHES_ROOT}/arches/_settings_local.py

COPY logging_config.py ${ARCHES_ROOT}/arches/settings_local.py

RUN chmod -R 750 ${WEB_ROOT}/entrypoint.sh && chgrp -R www-data ${WEB_ROOT}/entrypoint.sh

USER 33
