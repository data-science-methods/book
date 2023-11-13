CONTENT := $(wildcard content/*.qmd)

all: pages slides

.PHONY: site
site:
	quarto render

.PHONY: pages
site_files := $(patsubst content/%, docs/content/%, $(patsubst %.qmd, %.html, $(CONTENT)))
pages: $(site_files)
docs/content/%.html: content/%.qmd
	quarto render $<


.PHONY: slides
slides_files := $(patsubst content/%, _slides/content/%, $(patsubst %.qmd, %.html, $(CONTENT)))
slides: $(slides_files)
_slides/content/%.html: content/%.qmd slides.css
	## First version: revert to Rmarkdown to render slides
	# Rscript -e "rmarkdown::render('$<', output_format = rmarkdown::slidy_presentation(df_print = 'paged', pandoc_args = c('--bibliography=../book.bib', '--citeproc'), highlight = 'tango', css = '../slides.css'), output_dir = 'slides')"
	# Rscript -e "rmarkdown::render('$<', output_dir = 'slides', output_yaml = '../_output.yml')"
	## Second version: juggling different yml files
    # mv _quarto.yml _quarto_book.yml
    # mv _quarto_slides.yml _quarto.yml
    # quarto render $<
    # mv _quarto.yml _quarto_slides.yml
    # mv _quarto_book.yml _quarto.yml
	## Third version: Quarto profiles
	quarto render $< --profile slides
