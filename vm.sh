#!/bin/bash
command=$1

case "$command" in
  "create") virutal-machine/create-vm.sh "${@:2}";;
  "delete") virutal-machine/delete-vm.sh "${@:2}";;
  "list") virutal-machine/list-vm.sh "${@:2}";;
  *)
    echo "Invalid command." 1>&2
    exit 1
    ;;
esac