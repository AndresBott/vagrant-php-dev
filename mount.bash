#!/usr/bin/env bash

for var in "$@"
do
    IFS='|' read -r -a array <<< "$var"
    BINDMOUNT="${array[0]} ${array[1]} none defaults,bind 0 0"
    echo "adding loop: $BINDMOUNT mount to fstab"
    sudo grep -q -F "$BINDMOUNT" /etc/fstab || echo "$BINDMOUNT" >> /etc/fstab
    sudo mkdir -p "${array[1]}"
    sudo mount "${array[0]}"
done