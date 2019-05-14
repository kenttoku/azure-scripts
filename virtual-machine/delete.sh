#!/bin/bash

# Variables
vm_name=$1
resource_group=$2

# Delete VM
echo "Deleting VM."
az vm delete \
  --resource-group "$resource_group" \
  --name "$vm_name" \
  --yes
echo "VM deleted."