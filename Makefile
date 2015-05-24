
# all: default compilation target.
all: bworley.pdf

# .pdf: actual compilation target.
bworley.pdf:
	pdflatex -draftmode bworley
	bibtex bworley-ch01
	bibtex bworley-ch02
	bibtex bworley-ch03
	bibtex bworley-ch04
	bibtex bworley-ch05
	bibtex bworley-ch06
	bibtex bworley-ch07
	bibtex bworley-ch08
	bibtex bworley-ch09
	bibtex bworley-ch10
	pdflatex -draftmode bworley
	pdflatex -draftmode bworley
	pdflatex bworley

# clean: target to remove all intermediate compilation results.
clean:
	rm -f bworley.pdf
	rm -f bworley.aux bworley.log bworley.out
	rm -f bworley.toc bworley.loa bworley.lof bworley.lot
	rm -f bworley-ch01.aux bworley-ch01.bbl bworley-ch01.blg
	rm -f bworley-ch02.aux bworley-ch02.bbl bworley-ch02.blg
	rm -f bworley-ch03.aux bworley-ch03.bbl bworley-ch03.blg
	rm -f bworley-ch04.aux bworley-ch04.bbl bworley-ch04.blg
	rm -f bworley-ch05.aux bworley-ch05.bbl bworley-ch05.blg
	rm -f bworley-ch06.aux bworley-ch06.bbl bworley-ch06.blg
	rm -f bworley-ch07.aux bworley-ch07.bbl bworley-ch07.blg
	rm -f bworley-ch08.aux bworley-ch08.bbl bworley-ch08.blg
	rm -f bworley-ch09.aux bworley-ch09.bbl bworley-ch09.blg
	rm -f bworley-ch10.aux bworley-ch10.bbl bworley-ch10.blg

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

