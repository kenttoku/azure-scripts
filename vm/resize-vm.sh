#!/bin/bash

## Script to resize a vm
## Variables
vm_name=$1
resource_group=$2
size=$3

## Validate Variables
if [ -z "$vm_name" ]; then
  echo "You must provide a name for your VM." 1>&2
  exit 1
fi

if [ -z "$resource_group" ]; then
  echo "You must provide a resource group." 1>&2
  exit 1
fi

if [ -z "$size" ]; then
  echo "You must provide a size." 1>&2
  exit 1
fi

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

## Validate
echo "Validating new VM size."
if [ -z "$(az vm list-vm-resize-options -g $resource_group -n $vm_name --query [].name | grep "\"$size\"")" ]; then
  echo "Invalid size." 1>&2
  exit 1
fi

echo "Resizing VM"
az vm resize -g $resource_group -n $vm_name --size $size

if [ "$?" != "0" ]; then
  exit 1
fi

echo "Resize complete"