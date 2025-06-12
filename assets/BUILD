# Assets BUILD file - art assets and data files

package(default_visibility = ["//visibility:public"])

# All assets
filegroup(
    name = "all_assets",
    srcs = [
        ":brushes",
        ":geometry_nodes", 
        ":asset_catalog",
    ],
)

# Brush assets
filegroup(
    name = "brushes",
    srcs = glob([
        "brushes/*.blend",
    ], allow_empty = True),
)

# Geometry node assets
filegroup(
    name = "geometry_nodes",
    srcs = glob([
        "geometry_nodes/**/*.blend",
        "geometry_nodes/**/*.json",
    ], allow_empty = True),
)

# Asset catalog
filegroup(
    name = "asset_catalog",
    srcs = [
        "blender_assets.cats.txt",
        "LICENSE",
    ],
)
