CONTENT := $(wildcard content/*.qmd)

all: site slides

.PHONY: fullsite
fullsite:
	quarto render

.PHONY: site
site_files := $(patsubst content/%, docs/content/%, $(patsubst %.qmd, %.html, $(CONTENT)))
site: $(site_files)
docs/content/%.html: content/%.qmd
	quarto render $<


.PHONY: slides
slides_files := $(patsubst content/%, slides/%, $(patsubst %.qmd, %.html, $(CONTENT)))
slides: $(slides_files)
slides/%.html: content/%.qmd
	Rscript -e "rmarkdown::render('$<', output_format = rmarkdown::slidy_presentation(df_print = 'paged', pandoc_args = c('--bibliography=../book.bib', '--citeproc'), highlight = 'tango', css = '../slides.css'), output_dir = 'slides')"