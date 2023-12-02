#!/usr/bin/env bash
# Usage:
#   build_image.sh <language>

# Example:
#   build_image.sh visual-basic

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/functions.sh"
cd "$SCRIPT_DIR/.."

build_image() {
  local language=$1
  local dockerfile="$language/Dockerfile"
  local image_name="100hellos/$language:local"
  docker build -t "$image_name" -f "$dockerfile" "$language"
}

language=$1
echo "Building dependencies for: $language"
for dependency in $(find_dependencies "$language" | sort -u); do
  echo "Building dependency: $dependency"
  build_image "$dependency"
done

build_image "$language"
