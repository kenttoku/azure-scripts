#!/bin/bash
resource_group_name=$1

az group delete -yg $resource_group_name --no-wait
