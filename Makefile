# This script is initially borrowed from Wendelin Boehmer

NAME=main
APPENDIX=11
CONF=iclr2021

all: 
	pdflatex $(NAME).tex
	make bib
	pdflatex $(NAME).tex
	pdflatex $(NAME).tex
	make clean
	#make submit

bib: 
	if [ -e $(NAME).aux ] ; \
	then \
		echo COMPILE BIBTEX; \
		bibtex $(NAME).aux; \
	else \
		echo NO REFERENCES TO COMPILE; \
	fi;


submit:
	echo SPLIT PDF IN SUBMISSION AND APPENDIX
	$(eval END=$(shell echo $$(($(APPENDIX)-1))))
	pdftk $(NAME).pdf cat 1-$(END) output $(CONF)_submission.pdf
	pdftk $(NAME).pdf cat $(APPENDIX)-end output $(CONF)_supplementary.pdf

clean:
	rm -f $(NAME).aux $(NAME).bbl $(NAME).log $(NAME).out $(NAME).toc $(NAME).blg $(NAME).dvi $(NAME).ps $(NAME).nav $(NAME).snm $(NAME).vrb shortcuts.aux $(NAME).acn $(NAME).acr $(NAME).alg $(NAME).glg $(NAME).glo $(NAME).gls $(NAME).ist

