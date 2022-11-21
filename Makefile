.PHONY: build
build:
	julia --project=. -e 'import BuildJuliaBlogpost; BuildJuliaBlogpost.main(run_pandoc=false, create_tarball=true)'
