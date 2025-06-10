# Documentation BUILD file

package(default_visibility = ["//visibility:public"])

# API documentation generation
genrule(
    name = "python_api_docs",
    srcs = [
        "//source/blender:python",
        "//scripts:startup_scripts",
    ],
    outs = ["python_api_docs.html"],
    cmd = "$(location //tools:generate_api_docs) --output $@ --input $(SRCS)",
    tools = ["//tools:generate_api_docs"],
)

# Doxygen documentation for C/C++ code
genrule(
    name = "cpp_docs",
    srcs = glob([
        "doxygen/*.h",
        "doxygen/Doxyfile",
        "doxygen/*.html",
    ], allow_empty = True) + [
        "//source/blender:blender_modules",
        "//intern:intern_libs",
    ],
    outs = ["cpp_docs.tar.gz"],
    cmd = "cd doc/doxygen && doxygen Doxyfile && tar -czf ../../$@ html/",
)

# User manual and guides
filegroup(
    name = "user_guides",
    srcs = glob([
        "guides/**/*.rst",
        "guides/**/*.md",
    ], allow_empty = True),
)

# License files
filegroup(
    name = "licenses",
    srcs = glob([
        "license/**/*",
    ], allow_empty = True),
)

# Man page
genrule(
    name = "blender_manpage",
    srcs = ["manpage/blender.1.py"],
    outs = ["blender.1"],
    cmd = "python3 $(location manpage/blender.1.py) --output $@",
)
