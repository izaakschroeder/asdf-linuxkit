#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/linuxkit/linuxkit"
TOOL_NAME="linuxkit"
TOOL_TEST="linuxkit --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/v.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

current_arch() {
  case "$(uname -m)" in
  x86_64) echo -n "amd64" ;;
  aarch64 | arm64) echo -n "arm64" ;;
  *) fail "Unsupported architecture" ;;
  esac
}

current_platform() {
  case "$OSTYPE" in
  darwin*) echo "darwin" ;;
  linux*) echo "linux" ;;
  windows*) echo "windows" ;;
  *) fail "Unsupported platform" ;;
  esac
}

download_release() {
  local platform arch version filename url
  version="$1"
  filename="$2"
  platform="$(current_platform)"
  arch="$(current_arch)"

  url="$GH_REPO/releases/download/${version}/linuxkit-${platform}-${arch}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp "$ASDF_DOWNLOAD_PATH"/linuxkit "$install_path/linuxkit"
    chmod +x "$install_path/linuxkit"
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
