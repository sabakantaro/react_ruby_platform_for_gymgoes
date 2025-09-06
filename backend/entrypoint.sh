#!/bin/bash
set -e

# Export secret key base from generated file
export SECRET_KEY_BASE=$(cat /tmp/secret_key_base)

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"