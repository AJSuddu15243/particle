#!/bin/bash
# Bazel setup verification script for Blender

set -e

echo "🔧 Blender Bazel Build System Setup Verification"
echo "================================================"

# Check if Bazel/Bazelisk is installed
if command -v bazelisk &> /dev/null; then
    echo "✅ Bazelisk found: $(bazelisk version | grep "Bazelisk version" | head -n1)"
    BAZEL_CMD="bazelisk"
elif command -v bazel &> /dev/null; then
    echo "✅ Bazel found: $(bazel version | head -n1)"
    BAZEL_CMD="bazel"
else
    echo "❌ Neither Bazel nor Bazelisk is installed!"
    echo "Please install Bazelisk (recommended) or Bazel:"
    echo "  macOS: brew install bazelisk"
    echo "  Linux: See https://bazel.build/install/ubuntu"
    echo "  Windows: See https://bazel.build/install/windows"
    exit 1
fi

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed!"
    exit 1
fi

echo "✅ Python found: $(python3 --version)"

# Verify workspace structure
echo ""
echo "📁 Verifying workspace structure..."

required_files=(
    "WORKSPACE"
    "BUILD"
    ".bazelrc"
    "source/BUILD"
    "intern/BUILD"
    "extern/BUILD"
)

for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
        exit 1
    fi
done

# Test basic Bazel commands
echo ""
echo "🧪 Testing basic Bazel commands..."

echo "📋 Listing targets..."
if $BAZEL_CMD query --noshow_progress '//...' > /dev/null 2>&1; then
    echo "✅ Bazel query works"
else
    echo "❌ Bazel query failed"
    exit 1
fi

echo "🔍 Analyzing dependencies..."
if $BAZEL_CMD query --noshow_progress 'deps(//:blender)' > /dev/null 2>&1; then
    echo "✅ Dependency analysis works"
else
    echo "❌ Dependency analysis failed"
    exit 1
fi

# Try a simple build test (just parse, don't actually build)
echo "🏗️  Testing build configuration..."
if $BAZEL_CMD build --nobuild --config=macos //:blender > /dev/null 2>&1; then
    echo "✅ Build configuration is valid"
else
    echo "❌ Build configuration has errors"
    echo "Run '$BAZEL_CMD build --config=macos //:blender' to see detailed errors"
    exit 1
fi

echo ""
echo "🎉 Bazel setup verification completed successfully!"
echo ""
echo "Next steps:"
echo "  1. Run 'make build' to build Blender"
echo "  2. Run 'make test' to run tests"
echo "  3. Run 'make help' to see all available commands"
echo ""
echo "Note: The first build may take a while as Bazel downloads and builds dependencies."
