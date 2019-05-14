#!/bin/bash

# Handles commands for resource groups.
command=$1

case "$command" in
  "create") resource-group/create-resource-group.sh "${@:2}";;
  "delete") resource-group/delete-resource-group.sh "${@:2}";;
  *)
    echo "Invalid command." 1>&2
    exit 1
    ;;
esac