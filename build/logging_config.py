# https://docs.djangoproject.com/en/3.0/topics/logging/
# TODO: lidy up license

import os

from arches._settings_local import *

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
        },
    },
    'root': {
        'handlers': ['console'],
        'level': 'WARNING',
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': os.getenv('DJANGO_LOG_LEVEL', 'INFO'),
            'propagate': False,
        },
    },
}

# FIXME: introduce a solution such as https://github.com/korfuri/django-prometheus/issues/81
# that is compatible with health checking
ALLOWED_HOSTS = ['*']
