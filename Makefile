
# all: default compilation target.
all: bworley.pdf

# .pdf: actual compilation target.
bworley.pdf:
	pdflatex -draftmode bworley
	bibtex bworley-ch1
	bibtex bworley-ch2
	bibtex bworley-ch3
	bibtex bworley-ch4
	bibtex bworley-ch5
	bibtex bworley-ch6
	bibtex bworley-ch7
	bibtex bworley-ch8
	bibtex bworley-ch9
	pdflatex -draftmode bworley
	pdflatex -draftmode bworley
	pdflatex bworley

# clean: target to remove all intermediate compilation results.
clean:
	rm -f bworley.pdf
	rm -f bworley.aux bworley.log bworley.out
	rm -f bworley.toc bworley.lof bworley.lot
	rm -f bworley-ch1.aux bworley-ch1.bbl bworley-ch1.blg
	rm -f bworley-ch2.aux bworley-ch2.bbl bworley-ch2.blg
	rm -f bworley-ch3.aux bworley-ch3.bbl bworley-ch3.blg
	rm -f bworley-ch4.aux bworley-ch4.bbl bworley-ch4.blg
	rm -f bworley-ch5.aux bworley-ch5.bbl bworley-ch5.blg
	rm -f bworley-ch6.aux bworley-ch6.bbl bworley-ch6.blg
	rm -f bworley-ch7.aux bworley-ch7.bbl bworley-ch7.blg
	rm -f bworley-ch8.aux bworley-ch8.bbl bworley-ch8.blg
	rm -f bworley-ch9.aux bworley-ch9.bbl bworley-ch9.blg

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

