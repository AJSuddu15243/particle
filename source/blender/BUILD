# Blender source modules BUILD file

package(default_visibility = ["//visibility:public"])

# Collect all source files for the main blender library
filegroup(
    name = "blender_modules",
    srcs = [
        ":makesdna",
        ":makesrna",
        ":blenlib",
        ":blenkernel",
        ":blenloader",
        ":bmesh",
        ":editors",
        ":windowmanager",
        ":gpu",
        ":draw",
        ":render",
        ":python",
        ":imbuf",
        ":compositor",
        ":nodes",
        ":geometry",
        ":functions",
        ":modifiers",
        ":animation",
        ":depsgraph",
        ":simulation",
        ":freestyle",
        ":blenfont",
        ":sequencer",
        ":shader_fx",
        ":io_modules",
    ],
)

# DNA structure definitions
cc_library(
    name = "makesdna",
    srcs = glob([
        "makesdna/*.c",
        "makesdna/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "makesdna/*.h",
        "makesdna/**/*.h",
    ], allow_empty = True),
    includes = [
        "makesdna",
    ],
    copts = [
        "-DWITH_DNA_GHASH",
    ],
)

# RNA runtime type information
cc_library(
    name = "makesrna",
    srcs = glob([
        "makesrna/*.c",
        "makesrna/*.cc",
        "makesrna/intern/*.c",
        "makesrna/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "makesrna/*.h",
        "makesrna/**/*.h",
    ], allow_empty = True),
    includes = [
        "makesrna",
        "makesrna/intern",
    ],
    deps = [
        ":makesdna",
        ":blenlib",
    ],
)

# Blender library utilities
cc_library(
    name = "blenlib",
    srcs = glob([
        "blenlib/intern/*.c",
        "blenlib/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "blenlib/*.h",
        "blenlib/**/*.h",
    ], allow_empty = True),
    includes = [
        "blenlib",
    ],
    deps = [
        "//intern/guardedalloc",
        "//intern/atomic",
    ],
    copts = [
        "-DWITH_BLENDER",
    ],
)

# Blender kernel - core functionality
cc_library(
    name = "blenkernel",
    srcs = glob([
        "blenkernel/intern/*.c",
        "blenkernel/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "blenkernel/*.h",
        "blenkernel/**/*.h",
    ], allow_empty = True),
    includes = [
        "blenkernel",
    ],
    deps = [
        ":makesdna",
        ":makesrna",
        ":blenlib",
        ":imbuf",
        "//intern/guardedalloc",
        "//intern/memutil",
        "//intern/mikktspace",
        "//extern:extern_libs",
    ],
)

# File loading/saving
cc_library(
    name = "blenloader",
    srcs = glob([
        "blenloader/intern/*.c",
        "blenloader/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "blenloader/*.h",
        "blenloader/**/*.h",
    ], allow_empty = True),
    includes = [
        "blenloader",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        "//blenloader_core",
    ],
)

# Core blenloader functionality
cc_library(
    name = "blenloader_core",
    srcs = glob([
        "blenloader_core/intern/*.c",
        "blenloader_core/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "blenloader_core/*.h",
        "blenloader_core/**/*.h",
    ], allow_empty = True),
    includes = [
        "blenloader_core",
    ],
    deps = [
        ":makesdna",
        ":blenlib",
    ],
)

# BMesh mesh editing library
cc_library(
    name = "bmesh",
    srcs = glob([
        "bmesh/intern/*.c",
        "bmesh/intern/*.cc",
        "bmesh/operators/*.c",
        "bmesh/operators/*.cc",
        "bmesh/tools/*.c",
        "bmesh/tools/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "bmesh/*.h",
        "bmesh/**/*.h",
    ], allow_empty = True),
    includes = [
        "bmesh",
        "bmesh/intern",
        "bmesh/operators",
        "bmesh/tools",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        "//intern/mikktspace",
    ],
)

# Editors - UI editing functionality
cc_library(
    name = "editors",
    srcs = glob([
        "editors/**/intern/*.c",
        "editors/**/intern/*.cc",
        "editors/**/*.c",
        "editors/**/*.cc",
    ], exclude = [
        "editors/**/*_test.c",
        "editors/**/*_test.cc",
    ], allow_empty = True),
    hdrs = glob([
        "editors/**/*.h",
    ], allow_empty = True),
    includes = [
        "editors/include",
    ] + glob([
        "editors/*/intern",
        "editors/*",
    ], allow_empty = True),
    deps = [
        ":makesdna",
        ":makesrna",
        ":blenkernel",
        ":blenlib",
        ":bmesh",
        ":windowmanager",
        ":gpu",
        ":imbuf",
        ":python",
        "//intern/cycles",
    ],
)

# Window manager - handles UI events and windows
cc_library(
    name = "windowmanager",
    srcs = glob([
        "windowmanager/intern/*.c",
        "windowmanager/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "windowmanager/*.h",
        "windowmanager/**/*.h",
    ], allow_empty = True),
    includes = [
        "windowmanager",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":gpu",
        "//intern/ghost",
    ],
)

# GPU rendering abstraction
cc_library(
    name = "gpu",
    srcs = glob([
        "gpu/intern/*.c",
        "gpu/intern/*.cc",
        "gpu/opengl/*.c",
        "gpu/opengl/*.cc",
        "gpu/vulkan/*.c",
        "gpu/vulkan/*.cc",
        "gpu/metal/*.c",
        "gpu/metal/*.cc",
        "gpu/metal/*.m",
        "gpu/metal/*.mm",
    ], allow_empty = True),
    hdrs = glob([
        "gpu/*.h",
        "gpu/**/*.h",
    ], allow_empty = True),
    includes = [
        "gpu",
        "gpu/intern",
        "gpu/opengl",
        "gpu/vulkan",
        "gpu/metal",
    ],
    deps = [
        ":makesdna",
        ":blenlib",
        "//intern/guardedalloc",
        "//extern:extern_libs",
    ],
    copts = [
        "-DWITH_OPENGL_BACKEND",
    ] + select({
        "@bazel_tools//src/conditions:darwin": [
            "-DWITH_METAL_BACKEND",
        ],
        "//conditions:default": [],
    }),
)

# Draw manager - high level drawing
cc_library(
    name = "draw",
    srcs = glob([
        "draw/intern/*.c",
        "draw/intern/*.cc",
        "draw/engines/**/*.c",
        "draw/engines/**/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "draw/*.h",
        "draw/**/*.h",
    ], allow_empty = True),
    includes = [
        "draw",
        "draw/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":gpu",
        ":imbuf",
    ],
)

# Render engine
cc_library(
    name = "render",
    srcs = glob([
        "render/intern/*.c",
        "render/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "render/*.h",
        "render/**/*.h",
    ], allow_empty = True),
    includes = [
        "render",
        "render/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":imbuf",
        "//intern/cycles",
    ],
)

# Python integration
cc_library(
    name = "python",
    srcs = glob([
        "python/intern/*.c",
        "python/intern/*.cc",
        "python/generic/*.c",
        "python/generic/*.cc",
        "python/mathutils/*.c",
        "python/mathutils/*.cc",
        "python/bmesh/*.c",
        "python/bmesh/*.cc",
        "python/gpu/*.c",
        "python/gpu/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "python/*.h",
        "python/**/*.h",
    ], allow_empty = True),
    includes = [
        "python",
        "python/intern",
        "python/generic",
        "python/mathutils",
        "python/bmesh",
        "python/gpu",
    ],
    deps = [
        ":makesdna",
        ":makesrna",
        ":blenkernel",
        ":blenlib",
        ":bmesh",
        ":gpu",
        "//extern:python_libs",
    ],
    copts = [
        "-DWITH_PYTHON",
        "-DWITH_PYTHON_SECURITY",
    ],
)

# Image buffer - image processing
cc_library(
    name = "imbuf",
    srcs = glob([
        "imbuf/intern/*.c",
        "imbuf/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "imbuf/*.h",
        "imbuf/**/*.h",
    ], allow_empty = True),
    includes = [
        "imbuf",
        "imbuf/intern",
    ],
    deps = [
        ":makesdna",
        ":blenlib",
        "//intern/guardedalloc",
        "//extern:image_libs",
    ],
    copts = [
        "-DWITH_OPENEXR",
        "-DWITH_TIFF",
        "-DWITH_OPENJPEG",
        "-DWITH_DDS",
        "-DWITH_CINEON",
        "-DWITH_HDR",
        "-DWITH_WEBP",
    ],
)

# Compositor - node-based compositing
cc_library(
    name = "compositor",
    srcs = glob([
        "compositor/intern/*.cc",
        "compositor/nodes/*.cc",
        "compositor/operations/*.cc",
        "compositor/realtime_compositor/**/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "compositor/*.h",
        "compositor/**/*.h",
    ], allow_empty = True),
    includes = [
        "compositor",
        "compositor/intern",
        "compositor/nodes",
        "compositor/operations",
        "compositor/realtime_compositor",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":imbuf",
        ":nodes",
        ":gpu",
    ],
)

# Geometry nodes and utilities
cc_library(
    name = "geometry",
    srcs = glob([
        "geometry/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "geometry/*.h",
        "geometry/**/*.h",
    ], allow_empty = True),
    includes = [
        "geometry",
        "geometry/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":functions",
        ":nodes",
        "//extern:geometry_libs",
    ],
)

# Functions framework
cc_library(
    name = "functions",
    srcs = glob([
        "functions/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "functions/*.h",
        "functions/**/*.h",
    ], allow_empty = True),
    includes = [
        "functions",
        "functions/intern",
    ],
    deps = [
        ":blenlib",
        "//intern/guardedalloc",
    ],
)

# Node system
cc_library(
    name = "nodes",
    srcs = glob([
        "nodes/intern/*.cc",
        "nodes/composite/**/*.cc",
        "nodes/function/**/*.cc",
        "nodes/geometry/**/*.cc",
        "nodes/shader/**/*.cc",
        "nodes/texture/**/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "nodes/*.h",
        "nodes/**/*.h",
    ], allow_empty = True),
    includes = [
        "nodes",
        "nodes/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":functions",
        ":geometry",
        "//intern/cycles",
    ],
)

# Modifiers system
cc_library(
    name = "modifiers",
    srcs = glob([
        "modifiers/intern/*.c",
        "modifiers/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "modifiers/*.h",
        "modifiers/**/*.h",
    ], allow_empty = True),
    includes = [
        "modifiers",
        "modifiers/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":bmesh",
        ":geometry",
        "//extern:modifier_libs",
    ],
)

# Animation system (new animrig)
cc_library(
    name = "animation",
    srcs = glob([
        "animrig/intern/*.c",
        "animrig/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "animrig/*.h",
        "animrig/**/*.h",
    ], allow_empty = True),
    includes = [
        "animrig",
        "animrig/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
    ],
)

# Dependency graph
cc_library(
    name = "depsgraph",
    srcs = glob([
        "depsgraph/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "depsgraph/*.h",
        "depsgraph/**/*.h",
    ], allow_empty = True),
    includes = [
        "depsgraph",
        "depsgraph/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
    ],
)

# Physics simulation
cc_library(
    name = "simulation",
    srcs = glob([
        "simulation/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "simulation/*.h",
        "simulation/**/*.h",
    ], allow_empty = True),
    includes = [
        "simulation",
        "simulation/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":functions",
        ":geometry",
    ],
)

# Freestyle NPR renderer
cc_library(
    name = "freestyle",
    srcs = glob([
        "freestyle/intern/**/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "freestyle/intern/**/*.h",
    ], allow_empty = True),
    includes = [
        "freestyle/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":render",
    ],
    copts = [
        "-DWITH_FREESTYLE",
    ],
)

# Font rendering
cc_library(
    name = "blenfont",
    srcs = glob([
        "blenfont/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "blenfont/*.h",
    ], allow_empty = True),
    includes = [
        "blenfont",
    ],
    deps = [
        ":makesdna",
        ":blenlib",
        ":gpu",
        "//extern:font_libs",
    ],
)

# Video sequencer
cc_library(
    name = "sequencer",
    srcs = glob([
        "sequencer/intern/*.c",
        "sequencer/intern/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "sequencer/*.h",
        "sequencer/**/*.h",
    ], allow_empty = True),
    includes = [
        "sequencer",
        "sequencer/intern",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":imbuf",
        "//extern:ffmpeg_libs",
    ],
)

# Shader effects
cc_library(
    name = "shader_fx",
    srcs = glob([
        "shader_fx/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "shader_fx/*.h",
    ], allow_empty = True),
    includes = [
        "shader_fx",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":gpu",
    ],
)

# I/O modules
cc_library(
    name = "io_modules",
    srcs = glob([
        "io/**/*.c",
        "io/**/*.cc",
    ], allow_empty = True),
    hdrs = glob([
        "io/**/*.h",
    ], allow_empty = True),
    includes = [
        "io/common",
        "io/collada",
        "io/alembic",
        "io/usd",
        "io/wavefront_obj",
        "io/stl",
        "io/ply",
        "io/gpencil",
    ],
    deps = [
        ":makesdna",
        ":blenkernel",
        ":blenlib",
        ":bmesh",
        "//extern:io_libs",
    ],
    copts = [
        "-DWITH_ALEMBIC",
        "-DWITH_USD",
        "-DWITH_OPENCOLLADA",
        "-DWITH_IO_WAVEFRONT_OBJ",
        "-DWITH_IO_STL",
        "-DWITH_IO_PLY",
    ],
)
