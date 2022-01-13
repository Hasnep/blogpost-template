# Blogpost Template

## Building

To set up the blogpost, run:

```julia
import Pkg
Pkg.activate(".")
Pkg.instantiate()
include(joinpath(pwd(), "build.jl"))
```

To build the blogpost, run:

```julia
build(run_pandoc = false, create_tarball = false)
```

The raw output files will be in the `build` folder including an HTML file if pandoc is installed and an optional tarball file will be created in the project's root.
