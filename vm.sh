#!/bin/bash

##
validate_arg () {
  arg=$1
  arg_name=$2

  if [ -z "$arg" ]; then
    echo "Missing argument '$arg_name'." 1>&2
    exit 1
  fi
}

## Create VM
create () {
  ## Variables
  vm_name=$1
  resource_group=$2
  location=$3
  image=$4
  size=$5
  admin_username=$6

  ## Check for resource group. If resource group doesn't exist, create it
  echo "Validating resource group."
  if [ "$(az group exists --name "$resource_group")" = "false" ]; then
    echo "Resource group does not exist. Creating..."
    az group create -n "$resource_group" -l "$location"
  fi

  ## Checking existing VM for duplicates
  echo "Validating VM name."
  if [ -n "$(az vm list -g "$resource_group" --query [].name | grep "\"$vm_name\"")" ]; then
    echo "A VM with the name $vm_name already exists. Please use another name." 1>&2
    exit 1
  fi

  echo "VM name validated."
  echo "Creating VM..."

  ## Create VM
  echo
  az vm create \
    -n "$vm_name" \
    -g "$resource_group" \
    --image "$image" \
    --size "$size" \
    --admin-username "$admin_username" \
    --generate-ssh-keys \
    --custom-data ./cloud-init.txt
}

## Delete VM
delete () {
  ## Variables
  vm_name=$1
  resource_group=$2

  ## Check for resource group.
  echo "Validating resource group."
  if [ "$(az group exists --name "$resource_group")" = "false" ]; then
    echo "Resource group does not exist." 1>&2
    exit 1
  fi

  ## Checking existing VM for duplicates
  echo "Validating VM name."
  if [ -z "$(az vm list -g "$resource_group" --query [].name | grep "\"$vm_name\"")" ]; then
    echo "A VM with the name $vm_name does not exist." 1>&2
    exit 1
  fi

  ## Delete VM
  echo "Deleting VM."
  az vm delete -g "$resource_group" -n "$vm_name" -y
  echo "VM Deleted."
}

## Resize VM
resize () {
  ## Variables
  vm_name=$1
  resource_group=$2
  size=$3

  ## Check for resource group.
  echo "Validating resource group."
  if [ "$(az group exists --name "$resource_group")" = "false" ]; then
    echo "Resource group does not exist." 1>&2
    exit 1
  fi

  ## Checking existing VM for duplicates
  echo "Validating VM name."
  if [ -z "$(az vm list -g "$resource_group" --query [].name | grep "\"$vm_name\"")" ]; then
    echo "A VM with the name $vm_name does not exist." 1>&2
    exit 1
  fi

  ## Validate VM size name
  echo "Validating new VM size."
  if [ -z "$(az vm list-vm-resize-options -g "$resource_group" -n "$vm_name" --query [].name | grep "\"$size\"")" ]; then
    echo "Invalid size." 1>&2
    exit 1
  fi

  ## Resize VM
  echo "Resizing VM"
  az vm resize -g "$resource_group" -n "$vm_name" --size "$size"

  if [ "$?" != "0" ]; then
    exit 1
  fi

  echo "Resize complete"
}

main () {
  ## Main
  command=$1
  vm_name=$2
  resource_group=$3

  ## Check for azure-cli
  if [ -z "$(az -v)" ]; then
    echo "No azure-cli. Please install before continuing." 1>&2
    exit 1
  fi

  ## Validate required arguments
  validate_arg "$command" "command"
  validate_arg "$vm_name" "vm_name"
  validate_arg "$resource_group" "resource_group"

  case "$command" in
    "create")
      location=$4
      image=$5
      size=$6
      admin_username=$7

      ## Validate required arguments
      validate_arg "$location" "location"
      validate_arg "$image" "image"
      validate_arg "$size" "size"
      validate_arg "$admin_username" "admin_username"
      create "$vm_name" "$resource_group" "$location" "$image" "$size" "$admin_username"
      ;;
    "delete")
      delete "$vm_name" "$resource_group"
      ;;
    "resize")
      size=$4
      ## Validate required arguments
      validate_arg "$size" "size"
      resize "$vm_name" "$resource_group" "$size"
      ;;
    *)
      echo "Invalid command." 1>&2
      exit 1
      ;;
  esac
}

main "$@"