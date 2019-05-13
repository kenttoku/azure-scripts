#!/bin/bash

# Validates the existence of an argument.
# Script exits if it does not exist.

arg=$1
arg_name=$2

if [ -z "$arg" ]; then
  echo "Missing argument '$arg_name'" 1>&2
  exit 1
fi