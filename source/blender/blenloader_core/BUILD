# Blenloader core functionality

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "blenloader_core",
    srcs = glob([
        "intern/*.c",
        "intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "*.h",
        "**/*.h",
    ], allow_empty = True),
    includes = [
        ".",
    ],
    deps = [
        "//source/blender:makesdna",
        "//source/blender:blenlib",
    ],
)
