#!/bin/bash
set -e

rosrun $PACKAGE_NAME $NODE_NAME

echo "$@"