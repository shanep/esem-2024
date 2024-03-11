
%.pdf: %.tex
	latexmk -pdf $<

all: paper.pdf

.PHONY: clean
clean:
	git clean xfd
