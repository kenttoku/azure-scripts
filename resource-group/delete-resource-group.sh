#!/bin/bash

# Deletes the resource group.
# No confirmation
# No Wait
resource_group_name=$1

az group delete --no-wait -yg $resource_group_name
