#!/bin/bash
command=$1

case "$command" in
  "create") virutal-machine/create-vm.sh;;
  *)
    echo "Invalid command." 1>&2
    exit 1
    ;;
esac