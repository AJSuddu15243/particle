# CMake to Bazel Migration Guide for Blender

This guide helps developers familiar with Blender's CMake build system understand the equivalent Bazel concepts and commands.

## Command Equivalents

| Task | CMake | Bazel |
|------|-------|-------|
| **Configure** | `cmake -B build -S .` | `# Configuration in WORKSPACE` |
| **Build** | `make -C build -j8` | `bazel build //:blender` |
| **Clean** | `make -C build clean` | `bazel clean` |
| **Test** | `make -C build test` | `bazel test //tests:all_tests` |
| **Install** | `make -C build install` | `bazel run //release:install` |
| **Debug Build** | `cmake -DCMAKE_BUILD_TYPE=Debug` | `bazel build --config=dbg` |
| **Release Build** | `cmake -DCMAKE_BUILD_TYPE=Release` | `bazel build --config=opt` |

## Build Configuration

### CMake Options → Bazel Flags

| CMake Option | Bazel Equivalent |
|--------------|------------------|
| `-DWITH_CYCLES=ON` | `--copt=-DWITH_CYCLES` |
| `-DWITH_PYTHON=ON` | `--copt=-DWITH_PYTHON` |
| `-DWITH_OPENGL=ON` | `--copt=-DWITH_OPENGL` |
| `-DWITH_VULKAN=ON` | `--copt=-DWITH_VULKAN` |
| `-DCMAKE_C_COMPILER=clang` | `--action_env=CC=clang` |
| `-DCMAKE_CXX_COMPILER=clang++` | `--action_env=CXX=clang++` |

### Platform-Specific Builds

**CMake:**
```bash
# macOS
cmake -B build -S . -DCMAKE_OSX_ARCHITECTURES=arm64
make -C build

# Linux
cmake -B build -S . -DWITH_X11=ON -DWITH_WAYLAND=ON
make -C build

# Windows (cross-compile)
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=vcpkg.cmake
```

**Bazel:**
```bash
# macOS
bazel build //:blender --config=macos

# Linux  
bazel build //:blender --config=linux

# Windows
bazel build //:blender --config=windows
```

## File Structure Mapping

| CMake | Bazel | Purpose |
|-------|-------|---------|
| `CMakeLists.txt` (root) | `BUILD` + `WORKSPACE` | Main build configuration |
| `source/CMakeLists.txt` | `source/BUILD` | Source module definitions |
| `intern/CMakeLists.txt` | `intern/BUILD` | Internal library definitions |
| `extern/CMakeLists.txt` | `extern/BUILD` | External dependency handling |
| `build_files/cmake/` | `.bazelrc` | Build configuration |

## Target Definitions

### CMake Target Example
```cmake
# In source/blender/blenlib/CMakeLists.txt
add_library(bf_blenlib ${SRC})
target_include_directories(bf_blenlib PUBLIC .)
target_link_libraries(bf_blenlib bf_guardedalloc)
```

### Bazel Target Example
```python
# In source/blender/BUILD
cc_library(
    name = "blenlib",
    srcs = glob(["blenlib/intern/*.c"]),
    hdrs = glob(["blenlib/*.h"]),
    includes = ["blenlib"],
    deps = ["//intern:guardedalloc"],
)
```

## Dependency Management

### CMake
```cmake
# External dependencies
find_package(PkgConfig REQUIRED)
pkg_check_modules(OPENEXR REQUIRED OpenEXR)

# Internal dependencies
add_subdirectory(intern/guardedalloc)
target_link_libraries(blender bf_guardedalloc)
```

### Bazel
```python
# In WORKSPACE
http_archive(
    name = "openexr",
    urls = ["https://github.com/AcademySoftwareFoundation/openexr/..."],
)

# In BUILD
cc_binary(
    name = "blender",
    deps = [
        "//intern:guardedalloc",
        "@openexr//:openexr_libs",
    ],
)
```

## Common Workflows

### Development Build (CMake)
```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug -DWITH_CYCLES=ON
make -j$(nproc)
```

### Development Build (Bazel)
```bash
# Using Makefile wrapper
make debug

# Or directly
bazel build //:blender --config=macos --config=dbg
```

### Production Build (CMake)
```bash
mkdir build-release && cd build-release
cmake .. -DCMAKE_BUILD_TYPE=Release -DWITH_CYCLES=ON
make -j$(nproc)
make install
```

### Production Build (Bazel)
```bash
# Using Makefile wrapper
make release
make package

# Or directly
bazel build //:blender --config=macos --config=opt
bazel build //release:blender_macos_app
```

### Running Tests (CMake)
```bash
cd build
make test
# Or
ctest -V
```

### Running Tests (Bazel)
```bash
# All tests
bazel test //tests:all_tests

# Specific tests
bazel test //tests:blenlib_tests
bazel test //tests:cycles_tests

# With coverage
bazel coverage //tests:all_tests
```

## Advanced Features

### CMake: Custom Targets
```cmake
add_custom_target(blender_docs
    COMMAND doxygen ${CMAKE_SOURCE_DIR}/doc/Doxyfile
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
```

### Bazel: Custom Rules
```python
genrule(
    name = "blender_docs",
    srcs = ["doc/Doxyfile"],
    outs = ["docs.tar.gz"],
    cmd = "cd doc && doxygen Doxyfile && tar -czf ../$(location docs.tar.gz) html/",
)
```

### CMake: Conditional Compilation
```cmake
if(WITH_CYCLES)
    add_definitions(-DWITH_CYCLES)
    add_subdirectory(intern/cycles)
endif()
```

### Bazel: Conditional Compilation
```python
cc_library(
    name = "blender_core",
    deps = [
        "//intern:base_libs",
    ] + select({
        "//conditions:with_cycles": ["//intern/cycles:cycles_lib"],
        "//conditions:default": [],
    }),
)
```

## Performance Comparison

| Aspect | CMake | Bazel |
|--------|-------|-------|
| **Initial Build** | Slower (no caching) | Slower (first time) |
| **Incremental Build** | Good (make-based) | Excellent (fine-grained) |
| **Parallel Build** | Good (`make -j`) | Excellent (automatic) |
| **Clean Build** | Fast | Very fast |
| **Cross-Platform** | Good | Excellent |
| **Remote Caching** | Manual setup | Built-in support |

## Migration Strategy

1. **Phase 1**: Set up Bazel alongside CMake (current state)
2. **Phase 2**: Validate Bazel builds match CMake output
3. **Phase 3**: Update CI/CD to use Bazel
4. **Phase 4**: Switch development workflow to Bazel
5. **Phase 5**: Deprecate CMake (optional)

## Tips for CMake Users

1. **Build Location**: Bazel outputs to `bazel-bin/` instead of `build/`
2. **Configuration**: Set build options in `.bazelrc` instead of command line
3. **Debugging**: Use `bazel query` to understand dependency graphs
4. **IDE Integration**: Many IDEs support Bazel projects natively
5. **Caching**: Bazel's caching is more aggressive - trust incremental builds

## Troubleshooting

### CMake Works, Bazel Doesn't

1. **Check Dependencies**: Ensure external libs are defined in `WORKSPACE`
2. **Verify Includes**: Check that header paths are correctly specified
3. **Compare Flags**: Use `bazel build -s` to see actual compile commands
4. **Check Visibility**: Ensure targets are visible to dependents

### Performance Issues

1. **Limit Jobs**: Use `--jobs=N` if system is overloaded
2. **Enable Caching**: Configure remote or disk caching
3. **Profile Builds**: Use `bazel build --profile=profile.json`

This guide should help ease the transition from CMake to Bazel for Blender development.
