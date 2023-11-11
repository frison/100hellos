#!/usr/bin/env bash

find_dependencies() {
  local dir=$1
  local depth=${2:-0}
  if [[ $depth -gt 1 ]]; then
    return
  fi
  for parent in $(grep -h -o -E '100hellos/(.*):local' "$dir"/* 2>/dev/null | grep -v '/$' | cut -d/ -f2 | cut -d: -f1 | sort -u); do
    echo "$parent"
    find_dependencies "$parent" $((depth + 1))
  done
}

published_languages() {
  find . -maxdepth 1 -type d | sed 's|./||' | grep -vxFf .no-publish
}
