#!/bin/bash

# Script to create a VM
resource_group=$1
vm_name=$2
image=$3
size=$4
admin_username=$5

## Checking existing VM for duplicates
echo "Validating VM name."
if [ -n "$(az vm list -g "$resource_group" --query [].name --output  | grep "\"$vm_name\"")" ]; then
  echo "A VM with the name $vm_name already exists. Please use another name." 1>&2
  exit 1
fi
echo "VM name validated."

## Create VM
echo "Creating VM."
az vm create \
  --resource-group "$resource_group" \
  --name "$vm_name" \
  --image "$image" \
  --size "$size" \
  --admin-username "$admin_username" \
  --generate-ssh-keys
echo "VM created"