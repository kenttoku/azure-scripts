#!/bin/bash

# Creates the resource group.
resource_group_name=$1
location=$2

if [ -z "$resource_group_name" ]; then
  echo "Missing argument 'resource_group_name'." 1>&2
  exit 1
fi

if [ -z "$location" ]; then
  echo "Missing argument 'location'." 1>&2
  exit 1
fi

echo "Creating resource group."
az group create \
  --name "$resource_group_name" \
  --location "$location"
echo "Resource group created."
