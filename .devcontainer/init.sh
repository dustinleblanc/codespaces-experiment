#! /bin/bash

set -e

# Source our .env file to load env vars.
set -o allexport
source .env
set +o allexport

# Args
AUTH=${TERMINUS_TOKEN}
SITE=${PANTHEON_SITE}

# Attempting various logins
if [ ! -z "$AUTH" ]; then
  echo "Attempting to login via terminus..."
  terminus auth:login --machine-token="$AUTH" || terminus auth:login --email="$TERMINUS_USER" || terminus auth:login || exit 1
  echo "Logged in as `terminus auth:whoami`"

  # Do some basic validation to make sure we can access the site correctly
  if [ ! -z "$SITE" ]; then
    echo "Verifying that you have access to $SITE..."
    terminus site:info $SITE || exit 1
    echo "Access confirmed!"

    # LOCKR integration
    # If we don't have our dev cert already let's get it
    if ! openssl x509 -noout -text -in /var/www/certs/binding.pem 2>/dev/null | grep Pantheon 1>/dev/null; then
      echo "Pantheon LOCKR setup"
      mkdir -p /var/www/certs
      touch /var/www/certs/binding.pem
      $(terminus connection:info $SITE.dev --field=sftp_command):certs/binding.pem /var/www/certs/binding.pem
    fi

    # Lets also check to see if we should refresh our cert
    if openssl x509 -checkend 86400 -noout -in /var/www/certs/binding.pem; then
      echo "Cert is good!"
    else
      $(terminus connection:info $SITE.dev --field=sftp_command):certs/binding.pem /var/www/certs/binding.pem
    fi
  fi
fi

composer install
