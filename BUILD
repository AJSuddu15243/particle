# Root BUILD file for Blender
# This file defines the main targets for the Blender project

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

package(default_visibility = ["//visibility:public"])

# Define platform-specific configurations
config_setting(
    name = "linux",
    constraint_values = ["@platforms//os:linux"],
)

config_setting(
    name = "macos",
    constraint_values = ["@platforms//os:macos"],
)

config_setting(
    name = "windows",
    constraint_values = ["@platforms//os:windows"],
)

# Main Blender executable
cc_binary(
    name = "blender",
    srcs = ["//source/creator:blender_creator_srcs"],
    deps = [
        "//source/blender:blender_core",
        "//intern:intern_libs",
        "//extern:extern_libs",
    ] + select({
        ":linux": [
            "@linux_libs//:all",
        ],
        ":macos": [
            "@macos_libs//:all",
        ],
        ":windows": [
            "@windows_libs//:all",
        ],
        "//conditions:default": [],
    }),
    copts = [
        "-DWITH_BLENDER",
        "-DWITH_PYTHON",
        "-DWITH_PYTHON_SECURITY",
        "-DWITH_INTERNATIONAL",
        "-DWITH_OPENGL",
        "-DWITH_GPU_BACKEND",
    ] + select({
        ":linux": [
            "-DWITH_X11",
            "-DWITH_WAYLAND",
        ],
        ":macos": [
            "-DWITH_METAL",
            "-DWITH_COCOA",
        ],
        ":windows": [
            "-DWITH_WINDOWS",
        ],
        "//conditions:default": [],
    }),
    linkopts = select({
        ":linux": [
            "-lm",
            "-ldl",
            "-lpthread",
            "-lrt",
        ],
        ":macos": [
            "-framework Cocoa",
            "-framework OpenGL",
            "-framework Metal",
            "-framework Foundation",
            "-framework CoreFoundation",
        ],
        ":windows": [
            "-lkernel32",
            "-luser32",
            "-lgdi32",
            "-lcomdlg32",
        ],
        "//conditions:default": [],
    }),
)

# Cycles render engine as a separate library
cc_library(
    name = "cycles",
    deps = [
        "//intern/cycles:cycles_lib",
    ],
)

# Test target (only if test files exist)
cc_test(
    name = "blender_tests",
    srcs = glob(["tests/**/*.cc"], allow_empty = True),
    deps = [
        ":blender",
        "@com_google_googletest//:gtest_main",
    ],
)