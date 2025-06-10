# Tools BUILD file - development utilities

package(default_visibility = ["//visibility:public"])

# Python tools for development
py_library(
    name = "build_utils",
    srcs = glob([
        "utils_build/**/*.py",
    ], allow_empty = True),
    imports = ["utils_build"],
)

py_library(
    name = "maintenance_utils", 
    srcs = glob([
        "utils_maintenance/**/*.py",
    ], allow_empty = True),
    imports = ["utils_maintenance"],
)

py_library(
    name = "doc_utils",
    srcs = glob([
        "utils_doc/**/*.py", 
    ], allow_empty = True),
    imports = ["utils_doc"],
)

py_library(
    name = "api_utils",
    srcs = glob([
        "utils_api/**/*.py",
    ], allow_empty = True),
    imports = ["utils_api"],
)

# Code checking and formatting tools
py_binary(
    name = "code_clean",
    srcs = ["utils_maintenance/code_clean.py"],
    deps = [":maintenance_utils"],
    python_version = "PY3",
)

py_binary(
    name = "check_source",
    srcs = ["check_source/check_source.py"],  
    deps = [":maintenance_utils"],
    python_version = "PY3",
)

py_binary(
    name = "check_blender_release",
    srcs = glob(["check_blender_release/*.py"], allow_empty = True),
    main = "check_blender_release/check_blender_release.py",
    python_version = "PY3",
)

# Documentation generation
py_binary(
    name = "generate_api_docs",
    srcs = glob(["utils_doc/*.py"], allow_empty = True),
    main = "utils_doc/generate_api_docs.py", 
    deps = [":doc_utils"],
    python_version = "PY3",
)

# Build configuration tools
py_binary(
    name = "cmake_qtcreator_project",
    srcs = ["utils_ide/cmake_qtcreator_project.py"],
    python_version = "PY3",
)

# Git utilities
sh_binary(
    name = "git_log",
    srcs = ["git/git_log.sh"],
)

# Debug utilities
py_library(
    name = "debug_utils",
    srcs = glob([
        "debug/**/*.py",
    ], allow_empty = True),
    imports = ["debug"],
)

# Test utilities
py_library(
    name = "test_utils",
    srcs = glob([
        "utils/**/*.py",
    ], allow_empty = True),
    imports = ["utils"],
)
