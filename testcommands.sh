#!/bin/bash

command=$1

case "$command" in
  "createvm")
    vm/vm.sh create testvm vm-group southcentralus UbuntuLTS Standard_B1s kent
    ;;
  "deletevm")
    vm/vm.sh delete testvm vm-group
    ;;
  *)
    echo "Invalid command" 1>&2
    exit 1
    ;;
esac