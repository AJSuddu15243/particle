# Cycles render engine BUILD file

package(default_visibility = ["//visibility:public"])

# Main cycles library - unified target
cc_library(
    name = "cycles",
    deps = [
        ":cycles_lib",
    ],
)

# Detailed cycles library
cc_library(
    name = "cycles_lib",
    deps = [
        ":cycles_bvh",
        ":cycles_device", 
        ":cycles_graph",
        ":cycles_integrator",
        ":cycles_kernel",
        ":cycles_scene",
        ":cycles_session",
        ":cycles_subd",
        ":cycles_util",
        ":cycles_blender_integration",
    ],
)

# BVH acceleration structure
cc_library(
    name = "cycles_bvh",
    srcs = glob([
        "bvh/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "bvh/*.h",
    ], allow_empty = True),
    includes = ["bvh"],
    deps = [
        ":cycles_util",
    ],
)

# Device abstraction layer
cc_library(
    name = "cycles_device",
    srcs = glob([
        "device/*.cpp",
        "device/cpu/*.cpp",
    ]) + select({
        "@bazel_tools//src/conditions:darwin": glob([
            "device/metal/*.cpp",
            "device/metal/*.mm",
        ], allow_empty = True),
        "@bazel_tools//src/conditions:linux_x86_64": glob([
            "device/cuda/*.cpp",
            "device/optix/*.cpp",
            "device/hip/*.cpp",
            "device/hiprt/*.cpp",
            "device/oneapi/*.cpp",
        ], allow_empty = True),
        "//conditions:default": [],
    }),
    hdrs = glob([
        "device/*.h",
        "device/**/*.h",
    ], allow_empty = True),
    includes = [
        "device",
        "device/cpu",
        "device/cuda",
        "device/optix", 
        "device/hip",
        "device/hiprt",
        "device/metal",
        "device/oneapi",
        "device/dummy",
        "device/multi",
    ],
    deps = [
        ":cycles_util",
        ":cycles_kernel",
    ],
    copts = [
        "-DWITH_CYCLES_DEVICE_CPU",
    ] + select({
        "@bazel_tools//src/conditions:darwin": [
            "-DWITH_CYCLES_DEVICE_METAL",
        ],
        "@bazel_tools//src/conditions:linux_x86_64": [
            "-DWITH_CYCLES_DEVICE_CUDA",
            "-DWITH_CYCLES_DEVICE_OPTIX",
            "-DWITH_CYCLES_DEVICE_HIP",
            "-DWITH_CYCLES_DEVICE_HIPRT", 
            "-DWITH_CYCLES_DEVICE_ONEAPI",
        ],
        "//conditions:default": [],
    }),
)

# Scene graph
cc_library(
    name = "cycles_graph",
    srcs = glob([
        "graph/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "graph/*.h",
    ], allow_empty = True),
    includes = ["graph"],
    deps = [
        ":cycles_util",
    ],
)

# Path integrator
cc_library(
    name = "cycles_integrator",
    srcs = glob([
        "integrator/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "integrator/*.h",
    ], allow_empty = True),
    includes = ["integrator"],
    deps = [
        ":cycles_util",
        ":cycles_device",
        ":cycles_kernel",
    ],
)

# Rendering kernels
cc_library(
    name = "cycles_kernel",
    srcs = glob([
        "kernel/*.cpp",
        "kernel/camera/*.h",
        "kernel/closure/*.h", 
        "kernel/film/*.h",
        "kernel/geom/*.h",
        "kernel/integrator/*.h",
        "kernel/light/*.h",
        "kernel/sample/*.h",
        "kernel/svm/*.h",
        "kernel/util/*.h",
    ], allow_empty = True) + select({
        "@bazel_tools//src/conditions:darwin": glob([
            "kernel/device/metal/*.metal",
            "kernel/device/metal/*.h",
        ], allow_empty = True),
        "@bazel_tools//src/conditions:linux_x86_64": glob([
            "kernel/device/cuda/*.cu",
            "kernel/device/cuda/*.h",
            "kernel/device/optix/*.cu", 
            "kernel/device/optix/*.h",
            "kernel/device/hip/*.cpp",
            "kernel/device/hip/*.h",
        ], allow_empty = True),
        "//conditions:default": [],
    }),
    hdrs = glob([
        "kernel/*.h",
        "kernel/**/*.h",
    ], allow_empty = True),
    includes = [
        "kernel",
        "kernel/camera",
        "kernel/closure",
        "kernel/film", 
        "kernel/geom",
        "kernel/integrator",
        "kernel/light",
        "kernel/sample",
        "kernel/svm",
        "kernel/util",
        "kernel/device/cpu",
        "kernel/device/cuda",
        "kernel/device/optix",
        "kernel/device/hip",
        "kernel/device/metal",
        "kernel/device/oneapi",
    ],
    deps = [
        ":cycles_util",
        "//intern/sky",
    ],
)

# Scene management
cc_library(
    name = "cycles_scene",
    srcs = glob([
        "scene/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "scene/*.h",
    ], allow_empty = True),
    includes = ["scene"],
    deps = [
        ":cycles_util",
        ":cycles_bvh",
        ":cycles_graph",
        ":cycles_subd",
    ],
)

# Render session management
cc_library(
    name = "cycles_session",
    srcs = glob([
        "session/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "session/*.h",
    ], allow_empty = True),
    includes = ["session"],
    deps = [
        ":cycles_util",
        ":cycles_device",
        ":cycles_scene",
        ":cycles_integrator",
    ],
)

# Subdivision surfaces
cc_library(
    name = "cycles_subd",
    srcs = glob([
        "subd/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "subd/*.h",
    ], allow_empty = True),
    includes = ["subd"],
    deps = [
        ":cycles_util",
    ],
)

# Utilities
cc_library(
    name = "cycles_util",
    srcs = glob([
        "util/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "util/*.h",
    ], allow_empty = True),
    includes = ["util"],
    deps = [
        "//intern/guardedalloc",
    ],
)

# Blender integration
cc_library(
    name = "cycles_blender_integration",
    srcs = glob([
        "blender/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "blender/*.h",
    ], allow_empty = True),
    includes = ["blender"],
    deps = [
        ":cycles_scene",
        ":cycles_session",
        ":cycles_util",
        "//source/blender:makesdna",
        "//source/blender:blenkernel",
    ],
    copts = [
        "-DWITH_CYCLES_BLENDER",
    ],
)

# Standalone Cycles application (optional)
cc_binary(
    name = "cycles_standalone",
    srcs = glob([
        "app/*.cpp",
    ], allow_empty = True),
    deps = [
        ":cycles_lib",
        ":cycles_util",
    ],
    copts = [
        "-DWITH_CYCLES_STANDALONE",
    ],
)

# Hydra render delegate (optional)
cc_library(
    name = "cycles_hydra",
    srcs = glob([
        "hydra/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "hydra/*.h",
    ], allow_empty = True),
    includes = ["hydra"],
    deps = [
        ":cycles_lib",
        "//extern:usd_libs",
    ],
    copts = [
        "-DWITH_CYCLES_HYDRA_RENDER_DELEGATE",
        "-DWITH_USD",
    ],
)
