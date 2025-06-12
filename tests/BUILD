# Tests BUILD file - unit and integration tests

package(default_visibility = ["//visibility:public"])

# All tests target (placeholder until real tests are set up)
test_suite(
    name = "all_tests",
    tests = [
        ":blenlib_tests",
        ":cycles_tests",
        ":python_tests",
    ],
)

# BlenLib tests
cc_test(
    name = "blenlib_tests",
    srcs = glob([
        "gtests/blenlib/*.cc",
        "gtests/blenlib/*.cpp",
    ], allow_empty = True),
    deps = [
        "//source/blender:blenlib",
        "@com_google_googletest//:gtest_main",
    ],
)

# Cycles tests
cc_test(
    name = "cycles_tests",
    srcs = glob([
        "gtests/cycles/*.cc",
        "gtests/cycles/*.cpp",
    ], allow_empty = True),
    deps = [
        "//intern/cycles:cycles_lib",
        "@com_google_googletest//:gtest_main",
    ],
)

# Python API tests
py_test(
    name = "python_tests",
    srcs = glob([
        "python/*.py",
    ], allow_empty = True),
    main = "python/test_runner.py",
    deps = [
        "//scripts:startup_scripts",
    ],
    data = glob([
        "files/**/*",
    ], allow_empty = True),
)

cc_test(
    name = "bmesh_tests", 
    srcs = glob([
        "gtests/bmesh/*.cc",
    ], allow_empty = True),
    deps = [
        "//source/blender:bmesh",
        "@com_google_googletest//:gtest_main", 
    ],
)

cc_test(
    name = "functions_tests",
    srcs = glob([
        "gtests/functions/*.cc",
    ], allow_empty = True),
    deps = [
        "//source/blender:functions",
        "@com_google_googletest//:gtest_main",
    ],
)

cc_test(
    name = "geometry_tests",
    srcs = glob([
        "gtests/geometry/*.cc",
    ], allow_empty = True),
    deps = [
        "//source/blender:geometry",
        "@com_google_googletest//:gtest_main",
    ],
)

# Cycles integration tests
cc_test(
    name = "cycles_integration_tests",
    srcs = glob([
        "gtests/cycles/*.cc",
    ], allow_empty = True),
    deps = [
        "//intern/cycles:cycles_lib",
        "@com_google_googletest//:gtest_main",
    ],
)

# Performance tests
cc_test(
    name = "performance_tests",
    srcs = glob([
        "performance/**/*.cc",
    ], allow_empty = True),
    deps = [
        "//source/blender:blender_modules",
        "@com_google_googletest//:gtest_main",
    ],
    size = "large",
    timeout = "long",
)

# Complete test suite
test_suite(
    name = "all_tests_complete",
    tests = [
        ":python_tests",
        ":blenlib_tests", 
        ":bmesh_tests",
        ":functions_tests",
        ":geometry_tests",
        ":cycles_tests",
    ],
)
