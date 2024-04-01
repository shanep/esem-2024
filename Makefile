
%.pdf: %.tex
	latexmk -pdf $<

all: paper.pdf

.PHONY: bib
bib:
	wget --content-disposition -N https://paperpile.com/eb/zeDiJmjbZP

.PHONY: clean
clean:
	git clean -xfd
