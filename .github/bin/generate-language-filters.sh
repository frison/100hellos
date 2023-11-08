#!/usr/bin/env sh

for lang in $(find . -maxdepth 1 -type d | sed 's|./||' | grep -vxFf .no-publish)
do
  echo "$lang:"
  echo "  - '.github/**'"
  echo "  - '$lang/**'"
  dockerfile="$lang/Dockerfile"
  # For langs that reference bases
  for lang2 in $(find . -maxdepth 1 -type d | sed 's|./||')
  do
    if [ -e "$dockerfile" ] && grep -qE "100hellos/$lang2:local" "$dockerfile"; then
      echo "  - '$lang2/**'"
    fi
  done
done
