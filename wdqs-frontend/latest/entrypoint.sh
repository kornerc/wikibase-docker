#!/usr/bin/env bash
# This file is provided by the wikibase/wdqs-frontend docker image.

# Test if required environment variables have been set
for requiredVariable in WIKIBASE_HOST WDQS_HOST; do
    if [[ ! -v $requiredVariable || -z ${!requiredVariable} ]]; then
        printf >&2 '%s is required, but either unset or empty. You should pass it to docker. See: %s\n' \
            "$requiredVariable" \
            'https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file'
        exit 1
    fi
done

set -eu

export DOLLAR='$'
envsubst < /templates/config.js > /usr/share/nginx/html/wikibase/config.js
envsubst < /templates/default.conf > /etc/nginx/conf.d/default.conf

exec "$@"
