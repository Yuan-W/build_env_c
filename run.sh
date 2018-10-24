#!/bin/bash

ARGS=$@

if [[ $ARGS == *"menuconfig"* ]]; then
    make $ARGS -C /src
else
    mmake $ARGS -C /src
fi
