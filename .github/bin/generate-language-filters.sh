#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../../.utils/dependencies.sh"

for lang in $(find . -maxdepth 1 -type d | sed 's|./||' | grep -vxFf .no-publish)
do
  echo "$lang:"
  echo "  - '$lang/**'"
  for dep in $(find_dependencies $lang | sort -u); do
    echo "  - '$dep/**'"
  done
done
