# GHOST - Graphics Hardware Oriented System Toolkit

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "ghost",
    srcs = glob([
        "intern/*.cpp",
        "intern/*.c",
    ], allow_empty = True) + select({
        "@bazel_tools//src/conditions:linux_x86_64": glob([
            "intern/*_x11.cpp",
            "intern/*_wayland.cpp",
            "intern/*_linux.cpp",
        ], allow_empty = True),
        "@bazel_tools//src/conditions:darwin": glob([
            "intern/*_cocoa.mm",
            "intern/*_mac.cpp",
        ], allow_empty = True),
        "@bazel_tools//src/conditions:windows": glob([
            "intern/*_win32.cpp",
            "intern/*_windows.cpp",
        ], allow_empty = True),
        "//conditions:default": [],
    }),
    hdrs = glob([
        "*.h",
        "*.hh",
        "intern/*.h",
        "intern/*.hh",
    ], allow_empty = True),
    includes = [
        ".",
        "intern",
    ],
    deps = [
        "//intern/guardedalloc",
    ],
    copts = [
        "-DWITH_GHOST",
    ] + select({
        "@bazel_tools//src/conditions:linux_x86_64": [
            "-DWITH_X11",
            "-DWITH_WAYLAND",
        ],
        "@bazel_tools//src/conditions:darwin": [
            "-DWITH_COCOA",
        ],
        "@bazel_tools//src/conditions:windows": [
            "-DWITH_WINDOWS",
        ],
        "//conditions:default": [],
    }),
)
