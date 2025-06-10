# Blender Bazel Build System

This document describes the Bazel build system integration for Blender, providing an alternative to the traditional CMake build system.

## Prerequisites

- **Bazel**: Install from [bazel.build](https://bazel.build)
  - macOS: `brew install bazel`
  - Linux: Follow [Ubuntu installation guide](https://bazel.build/install/ubuntu)
  - Windows: Follow [Windows installation guide](https://bazel.build/install/windows)
- **Python 3.8+**: Required for build scripts and tools
- **Xcode Command Line Tools** (macOS): `xcode-select --install`
- **GCC/Clang**: Modern C++17 compatible compiler

## Quick Start

1. **Verify Setup**:
   ```bash
   ./verify_bazel_setup.sh
   ```

2. **Build Blender**:
   ```bash
   # Using the wrapper Makefile
   make build
   
   # Or directly with Bazel
   bazel build //:blender --config=macos
   ```

3. **Run Tests**:
   ```bash
   make test
   ```

## Build Targets

### Main Targets

- `//:blender` - Main Blender executable
- `//intern/cycles:cycles_lib` - Cycles render engine library
- `//intern/cycles:cycles_standalone` - Standalone Cycles application
- `//source/blender:blender_modules` - Core Blender libraries

### Test Targets

- `//tests:all_tests` - All test suites
- `//tests:blenlib_tests` - BlenLib unit tests
- `//tests:cycles_tests` - Cycles unit tests
- `//tests:python_tests` - Python API tests

### Documentation Targets

- `//doc:python_api_docs` - Python API documentation
- `//doc:cpp_docs` - C++ API documentation (Doxygen)

### Package Targets

- `//release:blender_macos_app` - macOS application bundle
- `//release:blender_linux_package` - Linux distribution package
- `//release:blender_windows_installer` - Windows installer

## Build Configurations

The build system supports multiple configurations defined in `.bazelrc`:

### Platform Configurations
- `--config=linux` - Linux-specific settings
- `--config=macos` - macOS-specific settings  
- `--config=windows` - Windows-specific settings

### Build Mode Configurations
- `--config=dbg` - Debug build (unoptimized, debug symbols)
- `--config=opt` - Release build (optimized, no debug symbols)

### Example Commands

```bash
# Debug build
bazel build //:blender --config=macos --config=dbg

# Release build
bazel build //:blender --config=macos --config=opt

# Build with specific features
bazel build //:blender --config=macos --define=with_cycles=true
```

## Makefile Wrapper

For convenience, a Makefile wrapper is provided:

```bash
make build          # Build Blender
make debug          # Debug build
make release        # Release build
make test           # Run all tests
make clean          # Clean build artifacts
make package        # Create release package
make docs           # Build documentation
make help           # Show all targets
```

## Project Structure

```
├── BUILD                    # Root build file
├── WORKSPACE               # Bazel workspace configuration
├── .bazelrc                # Bazel configuration
├── Makefile.bazel          # Makefile wrapper
├── verify_bazel_setup.sh   # Setup verification script
├── source/
│   ├── BUILD               # Source modules build file
│   ├── blender/BUILD       # Core Blender modules
│   └── creator/BUILD       # Main application entry
├── intern/
│   ├── BUILD               # Internal libraries
│   └── cycles/BUILD        # Cycles render engine
├── extern/
│   └── BUILD               # External dependencies
├── tests/
│   └── BUILD               # Test suites
├── scripts/
│   └── BUILD               # Python scripts and addons
├── assets/
│   └── BUILD               # Art assets and data files
├── doc/
│   └── BUILD               # Documentation generation
├── release/
│   └── BUILD               # Packaging and distribution
└── tools/
    └── BUILD               # Development tools
```

## Features

### Multi-Platform Support
- **macOS**: Native support with Metal backend
- **Linux**: X11/Wayland support with CUDA/OpenCL
- **Windows**: DirectX support (cross-compilation)

### Parallel Builds
Bazel automatically parallelizes builds based on dependency graphs and available CPU cores.

### Incremental Builds
Only changed components are rebuilt, significantly reducing build times.

### Remote Caching
Supports remote build caching for team development (configure in `.bazelrc`).

### Dependency Management
Automatic handling of external dependencies through WORKSPACE file.

## Development Workflow

### Building
```bash
# Quick build
make build

# Specific target
bazel build //intern/cycles:cycles_lib

# With custom flags
bazel build //:blender --copt=-DCUSTOM_FLAG
```

### Testing
```bash
# All tests
make test

# Specific test suite
bazel test //tests:blenlib_tests

# With coverage
bazel coverage //tests:all_tests
```

### Debugging
```bash
# Debug build
make debug

# Run with debugger
lldb bazel-bin/blender
```

## Configuration

### Build Options

Key build options can be configured in `.bazelrc` or passed as command-line flags:

- `--copt=-DWITH_CYCLES` - Enable Cycles render engine
- `--copt=-DWITH_PYTHON` - Enable Python scripting
- `--copt=-DWITH_OPENGL` - Enable OpenGL backend
- `--copt=-DWITH_VULKAN` - Enable Vulkan backend (Linux/Windows)
- `--copt=-DWITH_METAL` - Enable Metal backend (macOS)

### External Dependencies

External dependencies are managed in the `WORKSPACE` file:

```python
# Example: Adding a new dependency
http_archive(
    name = "my_library",
    urls = ["https://github.com/example/library/archive/v1.0.tar.gz"],
    strip_prefix = "library-1.0",
    build_file = "@//third_party:my_library.BUILD",
)
```

## Troubleshooting

### Common Issues

1. **Build Fails with Missing Dependencies**
   ```bash
   # Update external dependencies
   bazel sync
   bazel build //:blender
   ```

2. **Stale Build Artifacts**
   ```bash
   # Clean and rebuild
   bazel clean
   bazel build //:blender
   ```

3. **Memory Issues During Build**
   ```bash
   # Limit parallel jobs
   bazel build //:blender --jobs=4
   ```

4. **Python Import Errors**
   ```bash
   # Ensure Python path is correct
   export PYTHONPATH="${PWD}/scripts:${PYTHONPATH}"
   ```

### Getting Help

- Run `./verify_bazel_setup.sh` to check your setup
- Use `bazel query //...` to list all available targets
- Check `bazel info` for build information
- Consult [Bazel documentation](https://bazel.build/docs) for advanced usage

## Migration from CMake

This Bazel build system is designed to coexist with the existing CMake system. Key differences:

| CMake | Bazel |
|-------|-------|
| `mkdir build && cd build` | `bazel build //:blender` |
| `cmake ..` | Configured in `WORKSPACE` |
| `make -j8` | `bazel build --jobs=8` |
| `make test` | `bazel test //tests:all_tests` |
| `make install` | `bazel run //release:install` |

## Contributing

When adding new source files or dependencies:

1. Update the appropriate `BUILD` file
2. Run `./verify_bazel_setup.sh` to validate changes
3. Test with `bazel build //...` to ensure all targets build
4. Update this documentation if needed

## Performance Tips

- Use `--config=opt` for production builds
- Enable remote caching for team development
- Use `bazel query` to analyze dependency graphs
- Consider using `--compilation_mode=fastbuild` for development

## License

This build configuration follows the same license as Blender itself (GPL-3.0+).
