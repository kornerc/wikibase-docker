#!/usr/bin/env bash

# Test if required environment variables have been set
for requiredVariable in OAUTH_CONSUMER_KEY OAUTH_CONSUMER_SECRET QS_PUBLIC_SCHEME_HOST_AND_PORT WB_PUBLIC_SCHEME_HOST_AND_PORT WIKIBASE_SCHEME_AND_HOST WB_PROPERTY_NAMESPACE WB_PROPERTY_PREFIX WB_ITEM_NAMESPACE WB_ITEM_PREFIX; do
    if [[ ! -v $requiredVariable || -z ${!requiredVariable} ]]; then
        printf >&2 '%s is required, but either unset or empty. You should pass it to docker. See: %s\n' \
            "$requiredVariable" \
            'https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file'
        exit 1
    fi
done

envsubst < /templates/config.json > /var/www/html/quickstatements/public_html/config.json
envsubst < /templates/oauth.ini > /var/www/html/quickstatements/oauth.ini
envsubst < /templates/php.ini > /usr/local/etc/php/conf.d/php.ini

docker-php-entrypoint apache2-foreground
