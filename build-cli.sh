#!/usr/bin/env bash
set -euo pipefail

case "${1:-}" in
  x64) platform=linux/amd64 ;;
  arm64) platform=linux/arm64 ;;
  *) echo "Usage: $0 {x64|arm64}" >&2; exit 1 ;;
esac
arch=$1
cd "$(dirname "$0")"

image="vips-cli-linux-$arch"
docker build --platform="$platform" -t "$image" "platforms/linux-$arch"
docker run --rm --platform="$platform" -e VIPS_CLI=true -v "$PWD:/packaging" "$image" /packaging/build/posix.sh
