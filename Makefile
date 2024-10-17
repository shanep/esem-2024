# Makefile for ACM paper ID will be assigned by the publisher upon acceptance
PAPER_ID = 50
PROCEDINGS = esem24
PAPER_PILE_BIB = https://paperpile.com/eb/zeDiJmjbZP
TAPS := $(PROCEDINGS)-$(PAPER_ID)

%.pdf: %.tex
	latexmk -pdf -cd $<

FIGURE_DIR := figures
FIGURE_SRC := $(wildcard $(FIGURE_DIR)/*.tex)
FIGURES := $(FIGURE_SRC:.tex=.pdf)

all: $(FIGURES) paper slides handouts

paper: paper.pdf

slides: slides.pdf

handouts: slides.tex
	latexmk -pdf -cd -pdflatex='pdflatex %O -interaction=nonstopmode -synctex=1 "\PassOptionsToClass{handout}{beamer}\input{%S}"' --jobname=$@ $<

# Create a zip file for the TAPS submission
taps: paper
	mkdir -p $(TAPS)/pdf
	mkdir -p $(TAPS)/source/figures
	cp paper.pdf $(TAPS)/pdf/
	cp paper.tex $(TAPS)/source/
	cp paper.bib $(TAPS)/source/
	cp paper.bbl $(TAPS)/source/
	cp figures/*.pdf $(TAPS)/source/figures/
	zip -r $(TAPS).zip $(TAPS)/

arxiv: paper
	mkdir -p arxiv/figures/
	cp paper.tex arxiv
	cp paper.bib arxiv
	cp paper.bbl arxiv
	cp figures/*.pdf arxiv/figures/
	zip -r arxiv.zip arxiv/

checkcites: paper slides
	checkcites --unused $^

.PHONY: clean help
clean:
	cd $(FIGURE_DIR) && latexmk -c; rm -f *.synctex.gz && cd ..
	rm -f *.bbl *.aux *.fls *.log *.nav *.out *.snm *.snctex.gz *.xcp *.vrb *.toc *.synctex.gz *.fdb_latexmk *.pdf

help:
	@echo "all   - build all figures and paper"
	@echo "paper - build just the paper"
	@echo "taps  - build a zip file for submission to ACM taps"
	@echo "arxiv - build a zip file for submission to arxiv"
	@echo "checkcites - check the bib file to make sure everything is used"
	@echo "clean - removed all build cruft"
	@echo "help - this menu :)"
