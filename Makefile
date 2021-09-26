all: gitbook slides

gitbook: 
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"


RMD := $(wildcard ??-*.Rmd)
RMD := $(filter-out $(wildcard 99-*),$(RMD))
HANDOUTS_DIR := docs/handouts
HANDOUTS := $(addprefix $(HANDOUTS_DIR)/,$(patsubst %.Rmd,%.pdf,$(RMD)))
SLIDES_DIR := docs/slides
SLIDES := $(addprefix $(SLIDES_DIR)/,$(patsubst %.Rmd, %.html, $(RMD)))

# handouts: 
# 	@echo $(HANDOUTS)

handouts: $(HANDOUTS)
$(HANDOUTS_DIR)/%.pdf: %.Rmd
	Rscript -e "rmarkdown::render('$<', output_format = bookdown::pdf_document2(latex_engine = 'lualatex', includes = rmarkdown::includes(in_header = 'preamble.tex')), output_dir = '$(HANDOUTS_DIR)')"

slides: $(SLIDES)
$(SLIDES_DIR)/%.html: %.Rmd knitr_config.Rmd
	Rscript -e "rmarkdown::render('$<', output_format = rmarkdown::slidy_presentation(df_print = 'paged', pandoc_args = c('--bibliography=book.bib', '--citeproc')), output_dir = '$(SLIDES_DIR)')"
