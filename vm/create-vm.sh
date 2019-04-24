#!/bin/bash
## Script to create vm

## Variables
vm_name=$1
resource_group=$2
location=$3
image=$4
size=$5
admin_username=$6

## Validate Variables
if [ -z "$vm_name" ]; then
  echo "You must provide a name for your VM."
fi

if [ -z "$resource_group" ]; then
  echo "You must provide a resource group."
fi

if [ -z "$location" ]; then
  echo "You must provide a location."
fi

if [ -z "$image" ]; then
  echo "You must provide an image."
fi

if [ -z "$size" ]; then
  echo "You must provide a size."
fi

if [ -z "$admin_username" ]; then
  echo "You must provide an admin username."
fi

## Check for resource group. If resource group doesn't exist, create it
echo "Validating resource group."
if [ "$(az group exists --name $resource_group)" = "false" ]; then
  echo "Resource group does not exist. Creating..."
  az group create -n $resource_group -l $location
fi

## Checking existing VM for duplicates
echo "Validating VM name."
if [ -n "$(az vm list -g $resource_group --query [].name | grep "\"$vm_name\"")" ]; then
  echo "A VM with the name $vm_name already exists. Please use another name." 1>&2
  exit 1
fi

echo "VM name validated."
echo "Creating VM..."

## Create VM
echo
az vm create \
  -n $vm_name \
  -g $resource_group \
  --image $image \
  --size $size \
  --admin-username $admin_username
  --generate-ssh-keys