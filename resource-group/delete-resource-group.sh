#!/bin/bash

# Deletes the resource group.
# No confirmation
resource_group_name=$1

echo "Deleting resource group."
az group delete -yg "$resource_group_name"
echo "Resource group deleted."
