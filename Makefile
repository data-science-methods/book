all: gitbook pdf

gitbook: 
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"

slides:
	Rscript -e "bookdown::render_book('index.Rmd', 'rmarkdown::beamer_presentation', output_file = 'docs/slides')"