# Scripts BUILD file - Python modules and addons

package(default_visibility = ["//visibility:public"])

# Core addons
py_library(
    name = "addons_core",
    srcs = glob([
        "addons_core/**/*.py",
    ], allow_empty = True),
    imports = ["addons_core"],
    data = glob([
        "addons_core/**/*.blend",
        "addons_core/**/*.json",
        "addons_core/**/*.xml",
        "addons_core/**/*.txt",
    ], allow_empty = True),
)

# Startup scripts
py_library(
    name = "startup_scripts",
    srcs = glob([
        "startup/**/*.py",
    ], allow_empty = True),
    imports = ["startup"],
    deps = [
        ":modules",
    ],
)

# Python modules
py_library(
    name = "modules",
    srcs = glob([
        "modules/**/*.py",
    ], allow_empty = True),
    imports = ["modules"],
)

# Freestyle scripts
py_library(
    name = "freestyle_scripts",
    srcs = glob([
        "freestyle/**/*.py",
    ], allow_empty = True),
    imports = ["freestyle"],
)

# Presets
filegroup(
    name = "presets",
    srcs = glob([
        "presets/**/*.py",
    ], allow_empty = True),
)

# Templates
filegroup(
    name = "templates",
    srcs = glob([
        "templates_py/**/*.py",
        "templates_osl/**/*.osl",
        "templates_toml/**/*.toml",
    ], allow_empty = True),
)

# Site packages
py_library(
    name = "site_packages",
    srcs = glob([
        "site/**/*.py",
    ], allow_empty = True),
    imports = ["site"],
)
