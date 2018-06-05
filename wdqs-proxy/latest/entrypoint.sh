#!/usr/bin/env bash
# This file is provided by the wikibase/wdqs-proxy docker image.

# Test if required environment variables have been set
for requiredVariable in PROXY_PASS_HOST; do
    if [[ ! -v $requiredVariable || -z ${!requiredVariable} ]]; then
        printf >&2 '%s is required, but either unset or empty. You should pass it to docker. See: %s\n' \
            "$requiredVariable" \
            'https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file'
        exit 1
    fi
done

set -eu

envsubst < /etc/nginx/conf.d/wdqs.template > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
