#!/bin/bash

SCRIPT_PATH=$(cd $(dirname $0); pwd -P)

RESOURCES_PATH=$SCRIPT_PATH/../resources
BINARIES_PATH=$SCRIPT_PATH/../out/bin

$BINARIES_PATH/example_player $RESOURCES_PATH/holdem.limit.3p.game $1 $2
