# Atomic operations library

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "atomic",
    srcs = glob([
        "intern/*.c",
        "intern/*.cc",
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
