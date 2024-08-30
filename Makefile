# Makefile for ACM paper ID will be assigned by the publisher upon acceptance
PAPER_ID = 50
PROCEDINGS = esem24
DIR = $PROCEDINGS-$PAPER_ID
%.pdf: %.tex
	latexmk -pdf $<

all: paper.pdf

taps: paper.pdf
	mkdir -p $DIR/pdf
	mv paper.pdf $DIR/pdf/
	mkdir -p $DIR/source
	cp paper.tex $DIR/source/
	cp paper.bib $DIR/source/
	cp process-diagram.pdf $DIR/source/
	zip -r $DIR.zip $DIR/

.PHONY: bib
bib:
	wget --content-disposition -N https://paperpile.com/eb/zeDiJmjbZP

.PHONY: clean
clean:
	git clean -xfd
