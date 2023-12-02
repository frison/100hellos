#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_DIR="$SCRIPT_DIR/../.."
source "$REPO_DIR/.utils/functions.sh"

PUBLISHED_LANGUAGE_COUNT=$(published_languages | wc -l)
LANGUAGES_TO_GO=$((100 - PUBLISHED_LANGUAGE_COUNT))
if ! grep -q "${LANGUAGES_TO_GO}_to_go" $REPO_DIR/README.md; then
  ci_error "README.md does not have the correct language count! Are you unintentionally publishing an image? Or is there really ${LANGUAGES_TO_GO} to go!?"
fi
ci_pass "README.md has the correct language count! (${LANGUAGES_TO_GO} to go!)"


