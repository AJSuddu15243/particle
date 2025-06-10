# Creator module BUILD file - main application entry point

package(default_visibility = ["//visibility:public"])

# Blender creator sources - main application entry point
filegroup(
    name = "blender_creator_srcs",
    srcs = glob([
        "*.c",
        "*.cc",
        "*.cpp",
    ], allow_empty = True),
)

# Alternative library target for the creator module
cc_library(
    name = "creator_lib",
    srcs = [":blender_creator_srcs"],
    hdrs = glob(["*.h"], allow_empty = True),
    includes = ["."],
    deps = [
        "//source/blender:blender_modules",
        "//intern:intern_libs",
        "//extern:extern_libs",
    ],
    copts = [
        "-DWITH_BLENDER",
        "-DWITH_BUILDINFO",
        "-DWITH_PYTHON",
        "-DWITH_INTERNATIONAL",
    ],
)
