#!/bin/bash
command=$1

case "$command" in
  "create") virtual-machine/create.sh "${@:2}";;
  "delete") virtual-machine/delete.sh "${@:2}";;
  "list") ./virtual-machine/list.sh "${@:2}";;
  *)
    echo "Invalid command." 1>&2
    exit 1
    ;;
esac