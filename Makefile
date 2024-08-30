# Makefile for ACM paper ID will be assigned by the publisher upon acceptance
PAPER_ID = 50
PROCEDINGS = esem24
TAPS := $(PROCEDINGS)-$(PAPER_ID)

%.pdf: %.tex
	latexmk -pdf $<

paper: paper.pdf

taps: paper
	mkdir -p $(TAPS)/pdf
	mv paper.pdf $(TAPS)/pdf/
	mkdir -p $(TAPS)/source
	cp paper.tex $(TAPS)/source/
	cp paper.bib $(TAPS)/source/
	cp paper.bbl $(TAPS)/source/
	cp process-diagram.pdf $(TAPS)/source/
	zip -r $(TAPS).zip $(TAPS)/

.PHONY: bib
bib:
	wget --content-disposition -N https://paperpile.com/eb/zeDiJmjbZP

.PHONY: clean
clean:
	latexmk -c
	rm -f *.bbl
	rm -rf $(TAPS) $(TAPS).zip
