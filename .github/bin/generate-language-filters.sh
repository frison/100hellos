#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../../.utils/functions.sh"

for lang in $(published_languages)
do
  if [ "$lang" = "bash" ]; then
    continue
  fi

  echo "$lang:"
  echo "  - '$lang/**'"
  for dep in $(find_dependencies $lang | sort -u); do
    echo "  - '$dep/**'"
  done
done

# We always want to build at least one language container
# to ensure the build process works with non-image related changes
# that impact the builds. The bash container is our canary that builds
# under these exceptional circumstances.
echo "bash:"
echo "  - 'bash/**'"
echo "  - '000-base/**'"
echo "  - '.github/**'"
echo "  - '.utils/**'"
echo "  - 'Makefile'"
echo "  - 'Makefile.language-container.mk'"
