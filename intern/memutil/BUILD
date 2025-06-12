# Memory utilities library

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "memutil",
    srcs = glob([
        "intern/*.cpp",
        "intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "*.h",
        "intern/*.h",
    ], allow_empty = True),
    includes = [
        ".",
        "intern",
    ],
)
