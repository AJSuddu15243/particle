# Blender Workspace Configuration
workspace(name = "blender")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Bazel Skylib - common utilities
http_archive(
    name = "bazel_skylib",
    sha256 = "cd55a062e763b9349921f0f5db8c3933288dc8ba4f76dd9416aac68acee3cb94",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()

# Rules for Python
http_archive(
    name = "rules_python",
    sha256 = "9d04041ac92a0985e344235f5d946f71ac543f1b1565f2cdbc9a2aaee8adf55b",
    strip_prefix = "rules_python-0.26.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.26.0/rules_python-0.26.0.tar.gz",
)

load("@rules_python//python:repositories.bzl", "py_repositories")
py_repositories()

# Rules for foreign CC (for external C/C++ libraries)
http_archive(
    name = "rules_foreign_cc",
    sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
    strip_prefix = "rules_foreign_cc-0.9.0",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/0.9.0.tar.gz",
)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
rules_foreign_cc_dependencies()

# Google Test for unit testing
http_archive(
    name = "com_google_googletest",
    sha256 = "8cf4eaab3a13b27a95b7e74c58fb4c0788ad94d1f7ec65b20665c4caf1d245e8",
    strip_prefix = "googletest-1.14.0",
    urls = ["https://github.com/google/googletest/archive/v1.14.0.tar.gz"],
)

# Google Benchmark for performance testing
http_archive(
    name = "com_github_google_benchmark",
    sha256 = "6430e4092653380d9dc4ccb45a1e2dc9259d581f4866dc0759713126056bc1d7",
    strip_prefix = "benchmark-1.8.3",
    urls = ["https://github.com/google/benchmark/archive/v1.8.3.tar.gz"],
)

# Eigen - Linear algebra library (already in extern/)
new_local_repository(
    name = "eigen",
    path = "extern/Eigen3",
    build_file_content = """
cc_library(
    name = "eigen",
    hdrs = glob([
        "Eigen/**",
        "unsupported/**",
    ]),
    includes = ["."],
    visibility = ["//visibility:public"],
)
""",
)

# Platform-specific library dependencies
# macOS libraries
new_local_repository(
    name = "macos_libs",
    path = "lib/macos_arm64",
    build_file_content = """
# macOS-specific precompiled libraries
filegroup(
    name = "all",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)

# Individual library targets can be defined here
cc_library(
    name = "python",
    srcs = glob(["python/lib/*.dylib"]),
    hdrs = glob(["python/include/**/*.h"]),
    includes = ["python/include"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "openexr",
    srcs = glob(["openexr/lib/*.dylib", "openexr/lib/*.a"]),
    hdrs = glob(["openexr/include/**/*.h"]),
    includes = ["openexr/include"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "ffmpeg",
    srcs = glob(["ffmpeg/lib/*.dylib", "ffmpeg/lib/*.a"]),
    hdrs = glob(["ffmpeg/include/**/*.h"]),
    includes = ["ffmpeg/include"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "freetype",
    srcs = glob(["freetype/lib/*.dylib", "freetype/lib/*.a"]),
    hdrs = glob(["freetype/include/**/*.h"]),
    includes = ["freetype/include"],
    visibility = ["//visibility:public"],
)
""",
)

# Linux libraries (for cross-platform development)
new_local_repository(
    name = "linux_libs",
    path = "lib/linux_x64",
    build_file_content = """
filegroup(
    name = "all", 
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)
""",
)

# Windows libraries (for cross-platform development)
new_local_repository(
    name = "windows_libs",
    path = "lib/windows_x64",
    build_file_content = """
filegroup(
    name = "all",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)
""",
)

# USD (Universal Scene Description) - if available
# new_local_repository(
#     name = "usd",
#     path = "lib/macos_arm64/usd",
#     build_file_content = """
# cc_library(
#     name = "usd_libs",
#     srcs = glob(["lib/*.dylib", "lib/*.a"]),
#     hdrs = glob(["include/**/*.h"]),
#     includes = ["include"],
#     visibility = ["//visibility:public"],
# )
# """,
# )

# OpenVDB - if available as external dependency
# http_archive(
#     name = "openvdb",
#     # Configuration for OpenVDB would go here
# )

# Additional external dependencies can be added here as needed
# Examples:
# - Bullet Physics
# - OpenSubdiv  
# - Alembic
# - OpenColorIO
# - OpenImageIO
# - OSL (Open Shading Language)
# - LLVM (for OSL)