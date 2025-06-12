# Release BUILD file - packaging and distribution

package(default_visibility = ["//visibility:public"])

# Main application bundle
filegroup(
    name = "blender_app",
    srcs = [
        "//:blender",
    ],
)

# Data files that need to be included in release
filegroup(
    name = "datafiles",
    srcs = glob([
        "datafiles/**/*",
    ], allow_empty = True),
)

# Platform-specific release configurations
filegroup(
    name = "darwin_config",
    srcs = glob([
        "darwin/**/*",
    ], allow_empty = True),
)

filegroup(
    name = "windows_config", 
    srcs = glob([
        "windows/**/*",
    ], allow_empty = True),
)

# License and release notes
filegroup(
    name = "release_docs",
    srcs = glob([
        "license/**/*",
        "release_notes/**/*",
        "text/**/*",
    ], allow_empty = True),
)

# Extension templates
filegroup(
    name = "extensions",
    srcs = glob([
        "extensions/**/*",
    ], allow_empty = True),
)

# macOS application bundle
genrule(
    name = "blender_macos_app",
    srcs = [
        ":blender_app",
        ":datafiles",
        ":darwin_config",
        ":release_docs",
        "//scripts:startup_scripts",
        "//scripts:addons_core",
        "//assets:all_assets",
    ],
    outs = ["Blender.app.tar.gz"],
    cmd = """
        mkdir -p Blender.app/Contents/MacOS
        mkdir -p Blender.app/Contents/Resources
        cp $(location //:blender) Blender.app/Contents/MacOS/blender
        cp -r $(locations :datafiles) Blender.app/Contents/Resources/
        cp -r $(locations //scripts:startup_scripts) Blender.app/Contents/Resources/scripts/
        cp -r $(locations //scripts:addons_core) Blender.app/Contents/Resources/scripts/
        cp -r $(locations //assets:all_assets) Blender.app/Contents/Resources/assets/
        tar -czf $@ Blender.app
    """,
    target_compatible_with = ["@platforms//os:macos"],
)

# Windows installer package
genrule(
    name = "blender_windows_installer",
    srcs = [
        ":blender_app",
        ":datafiles", 
        ":windows_config",
        ":release_docs",
        "//scripts:startup_scripts",
        "//scripts:addons_core",
        "//assets:all_assets",
    ],
    outs = ["blender-installer.exe"],
    cmd = """
        # This would typically use NSIS or similar installer creator
        echo "Windows installer creation would go here" > $@
    """,
    target_compatible_with = ["@platforms//os:windows"],
)

# Linux package
genrule(
    name = "blender_linux_package",
    srcs = [
        ":blender_app",
        ":datafiles",
        ":release_docs", 
        "//scripts:startup_scripts",
        "//scripts:addons_core",
        "//assets:all_assets",
    ],
    outs = ["blender-linux.tar.xz"],
    cmd = """
        mkdir -p blender-linux
        cp $(location //:blender) blender-linux/
        cp -r $(locations :datafiles) blender-linux/
        cp -r $(locations //scripts:startup_scripts) blender-linux/scripts/
        cp -r $(locations //scripts:addons_core) blender-linux/scripts/
        cp -r $(locations //assets:all_assets) blender-linux/assets/
        tar -cJf $@ blender-linux
    """,
    target_compatible_with = ["@platforms//os:linux"],
)
