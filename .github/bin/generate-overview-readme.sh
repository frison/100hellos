#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../../.utils/dependencies.sh"

language=$1

# Replace the overview-template.md placeholder ${lang} with the language
# and generate the start of the README.md
cat "$SCRIPT_DIR/overview-template.md" | sed "s|\${lang}|$language|g" > "$language/README-Generated.md"

if [[ -f "$language/README.md" ]]; then
  cat "$language/README.md" >> "$language/README-Generated.md"
fi

