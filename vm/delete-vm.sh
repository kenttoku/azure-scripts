#!/bin/bash

## script to delete a vm

## Variables
vm_name=$1
resource_group=$2

## Check for resource group.
echo "Validating resource group."
if [ "$(az group exists --name $resource_group)" = "false" ]; then
  echo "Resource group does not exist." 1>&2
  exit 1
fi

## Checking existing VM for duplicates
echo "Validating VM name."
if [ -z "$(az vm list -g $resource_group --query [].name | grep "\"$vm_name\"")" ]; then
  echo "A VM with the name $vm_name does not exist." 1>&2
  exit 1
fi