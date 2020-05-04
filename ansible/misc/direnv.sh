#!/bin/bash

PROJECTDIR=$1
DIR="$( cd "$(dirname $( dirname "${BASH_SOURCE[0]}" ))" && pwd )"

eval "$(direnv hook bash)"

echo "source_env ${PROJECTDIR}" >> .envrc
direnv allow
cd .

echo "Script dir: $DIR"
echo "Project: $PROJECTDIR"
