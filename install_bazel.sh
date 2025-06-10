#!/bin/bash
# Quick Bazel installation script for macOS

set -e

echo "🔧 Installing Bazel for Blender development"
echo "=========================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed!"
    echo "Please install Homebrew first:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

echo "✅ Homebrew found"

# Install Bazel
echo "📦 Installing Bazel..."
brew install bazel

# Verify installation
echo "🧪 Verifying Bazel installation..."
bazel version

echo "✅ Bazel installed successfully!"
echo ""
echo "Next steps:"
echo "  1. Run './verify_bazel_setup.sh' to verify the complete setup"
echo "  2. Run 'make build' to build Blender with Bazel"
