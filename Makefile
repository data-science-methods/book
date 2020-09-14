all: gitbook pdf

gitbook: 
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"


RMD := $(wildcard ??-*.Rmd)
RMD := $(filter-out $(wildcard 99-*),$(RMD))
HANDOUTS_DIR := docs/handouts
HANDOUTS := $(addprefix $(HANDOUTS_DIR)/,$(patsubst %.Rmd,%.pdf,$(RMD)))

# handouts: 
# 	@echo $(HANDOUTS)

handouts: $(HANDOUTS)
$(HANDOUTS_DIR)/%.pdf: %.Rmd
	Rscript -e "rmarkdown::render('$<', output_format = bookdown::pdf_document2(latex_engine = 'lualatex', includes = rmarkdown::includes(in_header = 'preamble.tex')), output_dir = '$(HANDOUTS_DIR)')"
	