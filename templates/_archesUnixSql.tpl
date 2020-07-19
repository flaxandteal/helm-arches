{{/* vim: set filetype=mustache: */}}
{{/*
Set settings that would be found in a php.ini
configuration file for this service.
*/}}
{{- define "archesInitUnixSql" -}}
    CREATE DATABASE template_postgis WITH ENCODING 'UTF8' LC_COLLATE='en_US.utf8' LC_CTYPE='en_US.utf8';
    UPDATE pg_database SET datistemplate='true' WHERE datname='template_postgis';

    \c template_postgis

    CREATE EXTENSION IF NOT EXISTS postgis;
    GRANT ALL ON geometry_columns TO PUBLIC;
    GRANT ALL ON geography_columns TO PUBLIC;
    GRANT ALL ON spatial_ref_sys TO PUBLIC;

    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
{{- end -}}
