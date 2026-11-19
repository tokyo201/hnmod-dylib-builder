#!/bin/bash
# build_all_mods.sh - Compiles all .hnmod packages in mods/ to iOS arm64 .dylib libraries

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

MODS_DIR="$REPO_ROOT/mods"
ARTIFACTS_DIR="$REPO_ROOT/artifacts"
BUILD_TMP="$REPO_ROOT/_build_tmp"

echo "=========================================================="
echo " Horizon Native Mods (.hnmod) -> iOS arm64 (.dylib) Builder"
echo "=========================================================="

mkdir -p "$ARTIFACTS_DIR"
mkdir -p "$BUILD_TMP"

# Ensure Rust iOS target is installed if cargo is present
if command -v rustup &> /dev/null; then
    echo "[*] Ensuring Rust target 'aarch64-apple-ios' is installed..."
    rustup target add aarch64-apple-ios || true
fi

# Run the python converter
python3 "$SCRIPT_DIR/convert_hnmod.py" --all --mods-dir "$MODS_DIR" --output "$ARTIFACTS_DIR" --work-dir "$BUILD_TMP"

echo "[*] Cleaning up temporary build files..."
rm -rf "$BUILD_TMP"

echo "[✓] All done! Output artifacts are located in: $ARTIFACTS_DIR"
ls -lh "$ARTIFACTS_DIR"
