default: build

build:
	julia --project=. -e 'import BuildJuliaBlogpost; BuildJuliaBlogpost.build(pwd(), run_pandoc=true, create_tarball=true)'

watch:
	julia --project=. -e 'import BuildJuliaBlogpost; BuildJuliaBlogpost.watch(pwd(), run_pandoc=true, create_tarball=false)'
