
## Main
## Check for azure-cli
if [ -z "$(which az)" ]; then
  echo "No azure-cli. Please install before continuing." 1>&2
  exit 1
fi
