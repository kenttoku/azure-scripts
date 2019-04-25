#!/bin/bash

## Functions
## Validate Arguments
function validate_arg () {
  arg=$1
  arg_name=$2

  if [ -z "$arg" ]; then
    echo "Missing argument '$arg_name'." 1>&2
    exit 1
  fi
}

## Main
command=$1
disk_name=$2
resource_group=$3

## Check for azure-cli
if [ -z "$(which az)" ]; then
  echo "No azure-cli. Please install before continuing." 1>&2
  exit 1
fi

## Validate required arguments
validate_arg "$command" "command"
validate_arg "$disk_name" "vm_name"
validate_arg "$resource_group" "resource_group"

case "$command" in
  "create") echo "create";;
  "delete") echo "delete";;
  *)
    echo "Invalid command." 1>&2
    exit 1
    ;;
esac