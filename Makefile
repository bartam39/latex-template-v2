# Makefile — LaTeX Cheat Sheet Build
MAIN    = main
TEX     = pdflatex
FLAGS   = -shell-escape -interaction=nonstopmode -halt-on-error

.PHONY: all clean watch

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex style/*.sty sections/*.tex
	$(TEX) $(FLAGS) $(MAIN).tex
	$(TEX) $(FLAGS) $(MAIN).tex

clean:
	rm -f $(MAIN).pdf $(MAIN).aux $(MAIN).log $(MAIN).out $(MAIN).toc $(MAIN).fls $(MAIN).fdb_latexmk $(MAIN).synctex.gz
	rm -rf _minted-$(MAIN)/

watch:
	latexmk -pvc -pdf -interaction=nonstopmode -pdflatex="pdflatex -shell-escape %O %S" $(MAIN).tex
