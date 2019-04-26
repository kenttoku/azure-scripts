#!/bin/bash

command=$1

case "$command" in
  "createvm")
    vm/vm.sh create testvm vm-group southcentralus UbuntuLTS Standard_B1s kent
    ;;
  "deletevm")
    vm/vm.sh delete testvm vm-group
    ;;
  "createdisk")
    az disk create -g vm-group -n mavdisk --size-gb 30 --os-type Linux
    ;;
  "attachdisk")
    az vm disk attach -g vm-group --vm-name testvm -n mavdisk
    ;;
  *)
    echo "Invalid command" 1>&2
    exit 1
    ;;
esac
# az vm disk attach -g vm-group --vm-name testvm -n mavdisk
# az vm extension set -g thursday-rg --vm-name mavericks --publisher Microsoft.Azure.extensions --settings '{"fileUrl":"https://raw.githubusercontent.com/kenttoku/revature-p0/master/linux-setup.sh"}' --protected-settings '{"execute": "~/linux-setup.sh"}' --name customScript
# fdisk -l
# sudo mkfs -t ext4 /dev/sdc
# mount /dev/sdc /media/disk