# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "porta"
version = v"0.1.0"

# Collection of sources required to complete build
sources = [
    GitSource("https://github.com/bdoolittle/porta.git", "8408a19e8867f0993a53ab134a34297ae0f8977c")
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
make -C porta/gnu-make/
cp porta/gnu-make/bin/xporta $prefix/xporta
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products = [
    ExecutableProduct("xporta", :xporta)
]

# Dependencies that must be installed before this package can be built
dependencies = Dependency[
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
