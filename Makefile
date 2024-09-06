# Makefile for ACM paper ID will be assigned by the publisher upon acceptance
PAPER_ID = 50
PROCEDINGS = esem24
PAPER_PILE_BIB = https://paperpile.com/eb/zeDiJmjbZP
TAPS := $(PROCEDINGS)-$(PAPER_ID)

%.pdf: %.tex
	latexmk -pdf $<

paper: paper.pdf

# Create a zip file for the TAPS submission
taps: paper
	mkdir -p $(TAPS)/pdf
	cp paper.pdf $(TAPS)/pdf/
	mkdir -p $(TAPS)/source
	cp paper.tex $(TAPS)/source/
	cp paper.bib $(TAPS)/source/
	cp paper.bbl $(TAPS)/source/
	cp process-diagram.pdf $(TAPS)/source/
	zip -r $(TAPS).zip $(TAPS)/

arxiv: paper
	mkdir -p arxiv
	cp paper.tex arxiv
	cp paper.bib arxiv
	cp paper.bbl arxiv
	cp process-diagram.pdf arxiv
	zip -r arxiv.zip arxiv/

# Download the paperpile bib file if needed
.PHONY: bib
bib:
	wget --content-disposition -N $(PAPER_PILE_BIB)

.PHONY: clean
clean:
	rm -f paper.pdf *.synctex.gz *.bbl *.run.xml *.blg *.aux *.log *.out *.fls *.fdb_latexmk
	rm -rf $(TAPS) $(TAPS).zip arxiv arxiv.zip
