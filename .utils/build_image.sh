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
  shift
  local build_args=$*
  local dockerfile="$language/Dockerfile"
  local image_name="100hellos/$language:local"
  docker build $build_args -t "$image_name" -f "$dockerfile" "$language"
}

language=$1
shift
build_args=$*

echo "Building dependencies for: $language with docker args \"$build_args\""
for dependency in $(find_dependencies "$language" | sort -u); do
  echo "Building dependency: $dependency"
  build_image "$dependency" $build_args
done

build_image "$language" $build_args
