# Intern libraries BUILD file - internal utilities and support libraries

package(default_visibility = ["//visibility:public"])

# Collect all intern libraries
cc_library(
    name = "intern_libs",
    deps = [
        "//intern/guardedalloc",
        "//intern/atomic",
        "//intern/memutil",
        "//intern/ghost",
        "//intern/mikktspace",
        "//intern/sky",
        "//intern/cycles",
    ] + select({
        "@bazel_tools//src/conditions:linux_x86_64": [
            "//intern/libc_compat",
            "//intern/wayland_dynload",
        ],
        "@bazel_tools//src/conditions:windows": [
            "//intern/utfconv",
            "//intern/uriconvert",
        ],
        "//conditions:default": [],
    }),
)

# Memory allocation
cc_library(
    name = "guardedalloc",
    srcs = glob([
        "guardedalloc/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "guardedalloc/*.h",
    ], allow_empty = True),
    includes = ["guardedalloc"],
    copts = [
        "-DWITH_BLENDER",
    ],
)

# Atomic operations
cc_library(
    name = "atomic",
    srcs = glob([
        "atomic/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "atomic/*.h",
    ], allow_empty = True),
    includes = ["atomic"],
)

# Memory utilities
cc_library(
    name = "memutil",
    srcs = glob([
        "memutil/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "memutil/*.h",
    ], allow_empty = True),
    includes = ["memutil"],
)

# GHOST - Graphics Hardware Oriented System Toolkit (windowing)
cc_library(
    name = "ghost",
    srcs = glob([
        "ghost/intern/*.cpp",
        "ghost/intern/*.c",
    ], allow_empty = True) + select({
        "@bazel_tools//src/conditions:linux_x86_64": glob([
            "ghost/intern/*_x11.cpp",
            "ghost/intern/*_wayland.cpp",
            "ghost/intern/*_linux.cpp",
        ], allow_empty = True),
        "@bazel_tools//src/conditions:darwin": glob([
            "ghost/intern/*_cocoa.mm",
            "ghost/intern/*_mac.cpp",
        ], allow_empty = True),
        "@bazel_tools//src/conditions:windows": glob([
            "ghost/intern/*_win32.cpp",
            "ghost/intern/*_windows.cpp",
        ], allow_empty = True),
        "//conditions:default": [],
    }),
    hdrs = glob([
        "ghost/*.h",
        "ghost/**/*.h",
    ], allow_empty = True),
    includes = [
        "ghost",
        "ghost/intern",
    ],
    deps = [
        ":guardedalloc",
    ],
    copts = [
        "-DWITH_GHOST",
    ] + select({
        "@bazel_tools//src/conditions:linux_x86_64": [
            "-DWITH_X11",
            "-DWITH_WAYLAND",
        ],
        "@bazel_tools//src/conditions:darwin": [
            "-DWITH_COCOA",
        ],
        "@bazel_tools//src/conditions:windows": [
            "-DWITH_WINDOWS",
        ],
        "//conditions:default": [],
    }),
)

# Mikktspace tangent calculation
cc_library(
    name = "mikktspace",
    srcs = glob([
        "mikktspace/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "mikktspace/*.h",
    ], allow_empty = True),
    includes = ["mikktspace"],
)

# Eigen linear algebra wrapper
cc_library(
    name = "eigen",
    srcs = glob([
        "eigen/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "eigen/*.h",
    ], allow_empty = True),
    includes = ["eigen"],
    deps = [
        "//extern:eigen_external",
    ],
)

# Cycles render engine
cc_library(
    name = "cycles",
    srcs = glob([
        "cycles/**/*.cpp",
        "cycles/**/*.c",
    ], exclude = [
        "cycles/**/test_*.cpp",
        "cycles/**/test_*.c",
    ], allow_empty = True) + select({
        "@bazel_tools//src/conditions:darwin": glob([
            "cycles/**/*.mm",
            "cycles/**/*.m",
        ], allow_empty = True),
        "//conditions:default": [],
    }),
    hdrs = glob([
        "cycles/**/*.h",
        "cycles/**/*.hpp",
    ], allow_empty = True),
    includes = [
        "cycles/bvh",
        "cycles/device",
        "cycles/graph",
        "cycles/integrator",
        "cycles/kernel",
        "cycles/scene",
        "cycles/session",
        "cycles/subd",
        "cycles/util",
        "cycles/blender",
        "cycles/app",
        "cycles/hydra",
    ],
    deps = [
        ":guardedalloc",
        ":sky",
        "//extern:cycles_libs",
    ],
    copts = [
        "-DWITH_CYCLES",
        "-DWITH_CYCLES_LOGGING",
        "-DCCL_NAMESPACE_BEGIN=namespace ccl {",
        "-DCCL_NAMESPACE_END=}",
    ] + select({
        "@bazel_tools//src/conditions:darwin": [
            "-DWITH_METAL",
            "-DWITH_CYCLES_DEVICE_METAL",
        ],
        "@bazel_tools//src/conditions:linux_x86_64": [
            "-DWITH_CYCLES_DEVICE_CUDA",
            "-DWITH_CYCLES_DEVICE_OPTIX",
            "-DWITH_CYCLES_DEVICE_HIP",
        ],
        "//conditions:default": [],
    }),
)

# Logging
cc_library(
    name = "clog",
    srcs = glob([
        "clog/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "clog/*.h",
    ], allow_empty = True),
    includes = ["clog"],
    deps = [
        ":guardedalloc",
    ],
)

# IK solver
cc_library(
    name = "iksolver",
    srcs = glob([
        "iksolver/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "iksolver/*.h",
        "iksolver/**/*.h",
    ], allow_empty = True),
    includes = [
        "iksolver",
        "iksolver/intern",
    ],
    deps = [
        ":guardedalloc",
        ":eigen",
    ],
)

# ITASC inverse kinematics
cc_library(
    name = "itasc",
    srcs = glob([
        "itasc/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "itasc/*.hpp",
        "itasc/*.h",
    ], allow_empty = True),
    includes = ["itasc"],
    deps = [
        ":guardedalloc",
        ":eigen",
    ],
    copts = [
        "-DWITH_IK_ITASC",
    ],
)

# Sky model
cc_library(
    name = "sky",
    srcs = glob([
        "sky/source/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "sky/include/**/*.h",
    ], allow_empty = True),
    includes = [
        "sky/include",
        "sky/source",
    ],
)

# SLIM UV parameterization
cc_library(
    name = "slim",
    srcs = glob([
        "slim/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "slim/*.h",
    ], allow_empty = True),
    includes = ["slim"],
    deps = [
        ":eigen",
    ],
    copts = [
        "-DWITH_UV_SLIM",
    ],
)

# Internal OpenVDB wrapper
cc_library(
    name = "openvdb_intern",
    srcs = glob([
        "openvdb/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "openvdb/*.h",
    ], allow_empty = True),
    includes = ["openvdb"],
    deps = [
        "//extern:openvdb_external",
    ],
    copts = [
        "-DWITH_OPENVDB",
    ],
)

# Internal Quadriflow wrapper
cc_library(
    name = "quadriflow_intern",
    srcs = glob([
        "quadriflow/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "quadriflow/*.h",
    ], allow_empty = True),
    includes = ["quadriflow"],
    deps = [
        "//extern:quadriflow_external",
    ],
    copts = [
        "-DWITH_QUADRIFLOW",
    ],
)

# Internal Audaspace wrapper
cc_library(
    name = "audaspace_intern",
    srcs = glob([
        "audaspace/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "audaspace/*.h",
    ], allow_empty = True),
    includes = ["audaspace"],
    deps = [
        "//extern:audaspace_external",
    ],
    copts = [
        "-DWITH_AUDASPACE",
    ],
)

# Rigid body physics
cc_library(
    name = "rigidbody",
    srcs = glob([
        "rigidbody/intern/*.cpp",
    ], allow_empty = True),
    hdrs = glob([
        "rigidbody/*.h",
    ], allow_empty = True),
    includes = ["rigidbody"],
    deps = [
        "//extern:bullet_external",
    ],
    copts = [
        "-DWITH_BULLET",
    ],
)

# Linux-specific libraries
cc_library(
    name = "libc_compat",
    srcs = glob([
        "libc_compat/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "libc_compat/*.h",
    ], allow_empty = True),
    includes = ["libc_compat"],
    target_compatible_with = ["@platforms//os:linux"],
)

cc_library(
    name = "wayland_dynload",
    srcs = glob([
        "wayland_dynload/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "wayland_dynload/*.h",
    ], allow_empty = True),
    includes = ["wayland_dynload"],
    target_compatible_with = ["@platforms//os:linux"],
    copts = [
        "-DWITH_GHOST_WAYLAND_DYNLOAD",
    ],
)

# Windows-specific libraries
cc_library(
    name = "utfconv",
    srcs = glob([
        "utfconv/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "utfconv/*.h",
    ], allow_empty = True),
    includes = ["utfconv"],
    target_compatible_with = ["@platforms//os:windows"],
)

cc_library(
    name = "uriconvert",
    srcs = glob([
        "uriconvert/intern/*.c",
    ], allow_empty = True),
    hdrs = glob([
        "uriconvert/*.h",
    ], allow_empty = True),
    includes = ["uriconvert"],
    target_compatible_with = ["@platforms//os:windows"],
)
