
# NAME: base name of all generated files.
NAME=bworley

# CHAPTERS: list of all chapters.
CHAPTERS=abs ack pub
CHAPTERS+= ch01 ch02 ch03 ch04 ch05 ch06
CHAPTERS+= ch07 ch08 ch09 ch10 ch11 ch12

# all: default compilation target.
all: $(NAME).pdf

# .pdf: actual compilation target.
$(NAME).pdf:
	pdflatex -draftmode $(NAME)
	for ch in $(CHAPTERS); do \
	  bibtex $(NAME)-$${ch}; \
	done
	pdflatex -draftmode $(NAME)
	pdflatex -draftmode $(NAME)
	pdflatex $(NAME)

# lo.pdf: low-resolution compilation target.
$(NAME)-lo.pdf: $(NAME).pdf
	env NAME=$(NAME) ./$(NAME)-lo.sh

# clean: target to remove all intermediate compilation results.
clean:
	rm -f $(NAME).pdf $(NAME).aux $(NAME).log $(NAME).out
	rm -f $(NAME).toc $(NAME).loa $(NAME).lof $(NAME).lot
	rm -f $(NAME)-lo.pdf
	for ch in $(CHAPTERS); do \
	  rm -f $(NAME)-$${ch}.aux $(NAME)-$${ch}.bbl $(NAME)-$${ch}.blg; \
	done

# again: target to clean and recompile the default target.
again: clean all

# lines: target to count the number of lines of tex.
lines:
	wc -l *.tex

# dist: target to package the current source tree into a tarball.
dist: clean
	tar czf ../thesis.tar.gz ./*

# diff: target to diff all tracked changes in the git repo.
diff:
	git diff --color

