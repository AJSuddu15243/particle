# External libraries BUILD file - third-party dependencies

package(default_visibility = ["//visibility:public"])

# Collect all external libraries
cc_library(
    name = "extern_libs",
    deps = [
        ":python_libs",
        ":image_libs",
        ":geometry_libs",
        ":io_libs",
        ":modifier_libs",
        ":font_libs",
        ":ffmpeg_libs",
        ":cycles_libs",
        ":eigen_external",
        ":openvdb_external",
        ":quadriflow_external",
        ":audaspace_external",
        ":bullet_external",
    ],
)

# Python libraries
cc_library(
    name = "python_libs",
    srcs = [],
    deps = [
        # These would typically be system dependencies or pre-built libraries
        # For now we'll reference them as external dependencies
    ],
    copts = [
        "-DWITH_PYTHON",
    ],
)

# Image format libraries
cc_library(
    name = "image_libs",
    srcs = [],
    deps = [
        # OpenEXR, TIFF, OpenJPEG, etc.
    ],
    copts = [
        "-DWITH_OPENEXR",
        "-DWITH_TIFF",
        "-DWITH_OPENJPEG",
    ],
)

# Geometry processing libraries
cc_library(
    name = "geometry_libs",
    srcs = [],
    deps = [
        # Manifold, CGAL, etc.
    ],
)

# I/O libraries
cc_library(
    name = "io_libs",
    srcs = [],
    deps = [
        # USD, Alembic, OpenCollada, etc.
    ],
    copts = [
        "-DWITH_USD",
        "-DWITH_ALEMBIC",
        "-DWITH_OPENCOLLADA",
    ],
)

# Modifier libraries
cc_library(
    name = "modifier_libs",
    srcs = [],
    deps = [
        # Various modifier-specific libraries
    ],
)

# Font libraries
cc_library(
    name = "font_libs",
    srcs = [],
    deps = [
        # FreeType, HarfBuzz, etc.
    ],
    copts = [
        "-DWITH_FREETYPE",
        "-DWITH_HARFBUZZ",
    ],
)

# FFmpeg libraries
cc_library(
    name = "ffmpeg_libs",
    srcs = [],
    deps = [
        # FFmpeg libraries
    ],
    copts = [
        "-DWITH_FFMPEG",
    ],
)

# Cycles-specific libraries
cc_library(
    name = "cycles_libs",
    srcs = [],
    deps = [
        # OSL, OpenImageIO, etc.
    ],
    copts = [
        "-DWITH_CYCLES_OSL",
        "-DWITH_OPENIMAGEIO",
    ],
)

# Eigen linear algebra library
cc_library(
    name = "eigen_external",
    srcs = [],
    hdrs = glob([
        "Eigen3/**/*.h",
        "Eigen3/**/*.hpp",
    ], allow_empty = True),
    includes = [
        "Eigen3",
    ],
    strip_include_prefix = "Eigen3",
)

# OpenVDB
cc_library(
    name = "openvdb_external",
    srcs = [],
    copts = [
        "-DWITH_OPENVDB",
    ],
)

# Quadriflow
cc_library(
    name = "quadriflow_external",
    srcs = [],
    copts = [
        "-DWITH_QUADRIFLOW",
    ],
)

# Audaspace
cc_library(
    name = "audaspace_external",
    srcs = [],
    copts = [
        "-DWITH_AUDASPACE",
    ],
)

# Bullet physics
cc_library(
    name = "bullet_external",
    srcs = [],
    hdrs = glob([
        "bullet2/**/*.h",
        "bullet2/**/*.hpp",
    ], allow_empty = True),
    includes = [
        "bullet2/src",
    ],
    copts = [
        "-DWITH_BULLET",
    ],
)
