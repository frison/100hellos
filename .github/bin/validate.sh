#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_DIR="$SCRIPT_DIR/../.."
source "$REPO_DIR/.utils/dependencies.sh"

PUBLISHED_LANGUAGE_COUNT=$(published_languages | wc -l)
LANGUAGES_TO_GO=$((100 - PUBLISHED_LANGUAGE_COUNT))
if ! grep -q "${LANGUAGES_TO_GO}_to_go" $REPO_DIR/README.md; then
  ci_error "README.md does not have the correct language count! (${LANGUAGES_TO_GO} to go!)"
fi
ci_check "README.md has the correct language count! (${LANGUAGES_TO_GO} to go!)"


