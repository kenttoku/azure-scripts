#!/bin/bash

# Deletes the resource group.
# No confirmation
resource_group_name=$1

if [ -z "$resource_group_name" ]; then
  echo "Missing argument 'resource_group_name'." 1>&2
  exit 1
fi

echo "Deleting resource group."
az group delete -yg "$resource_group_name"
echo "Resource group deleted."
