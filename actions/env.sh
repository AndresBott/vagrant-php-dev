#!/bin/bash

function printHelp(){
echo ""
echo "* start           Start the developement environment"
echo "* stop          Stop the developement environment"
echo "* recreate         Delete and recreate the developement environment"
}

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
VAGRANT=`realpath "${SCRIPTPATH}/../vagrant"`

cd ${VAGRANT}

if [ "$1" == "start" ]; then
    echo "Starting "
    vagrant up

elif  [ "$1" == "stop" ]; then
    echo "Stopping"
    vagrant halt
elif  [ "$1" == "recreate" ]; then
    echo "Deleting vagrant machine"
    vagrant destroy -f
    echo "Starting new vagrant environment"
    vagrant up
else
    printHelp
fi