#!/usr/bin/env bash
# Usage:
#   new.sh folder-name


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/dependencies.sh"
REPO_DIR="$SCRIPT_DIR/.."

NEW_FOLDER=$1
if [[ -z "$NEW_FOLDER" ]]; then
  echo "Usage: new.sh <folder-name>"
  exit 1
fi

if [[ -d "$NEW_FOLDER" ]]; then
  echo "Cannot create new folder: $NEW_FOLDER"
  echo "Error: Folder already exists"
  exit 1
fi

cp -r .template $NEW_FOLDER

# This approach is simpler than fixing the Makefile's "build this directory"
# logic.
mv $NEW_FOLDER/template.Dockerfile $NEW_FOLDER/Dockerfile

# Decrement how many left are to go!
PUBLISHED_LANGUAGE_COUNT=$(published_languages | wc -l)
LANGUAGES_TO_GO=$((100 - PUBLISHED_LANGUAGE_COUNT))
echo $LANGUAGES_TO_GO
sed -i "s|[0-9]\+_to_go|${LANGUAGES_TO_GO}_to_go|g" $REPO_DIR/README.md
