import Literate
import Tar
import TOML

function build(; run_pandoc = false, create_tarball = false)
    # Setup
    build_folder = joinpath(pwd(), "build")
    rm(build_folder, force = true, recursive = true)
    mkpath(build_folder)

    # Read metadata
    matadata_file_path = joinpath(pwd(), "metadata.toml")
    metadata = TOML.parsefile(matadata_file_path)
    id = metadata["id"]

    # Build markdown document
    input_jl_file_path = joinpath(pwd(), "src", id * ".jl")
    Literate.markdown(
        input_jl_file_path,
        build_folder;
        documenter = false,
        execute = true,
        preprocess = s -> replace(s, "# hide\n" => "#hide\n")    # Fix auto-formatted hide comments
    )

    # Copy metadata file to build build folder
    cp(matadata_file_path, joinpath(build_folder, "metadata.toml"); force = true)

    # Build to html using pandoc
    if run_pandoc
        built_md_file_path = joinpath(build_folder, id * ".md")
        built_html_file_path = joinpath(build_folder, id * ".html")
        @info "Building markdown to HTML file at `$built_html_file_path`."
        run(
            Cmd([
                "pandoc",
                built_md_file_path,
                "--from=markdown",
                "--to=html",
                "--standalone",
                "--output=" * built_html_file_path,
            ]),
        )
    end

    if create_tarball
        tarball_file_path = joinpath(pwd(), id * ".tar")
        @info "Creating tarball file at `$tarball_file_path`."
        Tar.create(build_folder, tarball_file_path)
    end

    return nothing
end

if !isinteractive()
    build(run_pandoc = false, create_tarball = true)
end
