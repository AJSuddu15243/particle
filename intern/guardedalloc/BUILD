# Guardedalloc memory management library

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "guardedalloc",
    srcs = glob([
        "intern/*.cc",
        "intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "*.h",
        "intern/*.hh",
        "intern/*.h",
    ], allow_empty = True),
    includes = [
        ".",
        "intern",
        "source/blender/blenlib",
    ],
    copts = [
        "-DWITH_BLENDER",
    ],
)
