# Sky model library

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "sky",
    srcs = glob([
        "source/*.cpp",
        "source/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "include/**/*.h",
        "include/**/*.hpp",
        "source/*.h",
        "source/*.hpp",
    ], allow_empty = True),
    includes = [
        "include",
        "source",
    ],
)
