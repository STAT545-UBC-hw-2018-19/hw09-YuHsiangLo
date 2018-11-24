all: report.html README.md

clean:
	rm -rf data plots report.md report.html README.md

report.html: report.Rmd histogram.png histogram.tsv
	Rscript -e 'rmarkdown::render("$<")'

README.md: README.Rmd first.png last.png common.png
	Rscript -e 'rmarkdown::render("$<")'

common.png: common.R words.txt
	Rscript $<

last.png: last.R words.txt
	Rscript $<

first.png: first.R words.txt
	Rscript $<

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("./data/$<")); ggsave("./plots/$@")'
	rm Rplots.pdf

histogram.tsv: histogram.R words.txt
	Rscript $<

words.txt: /usr/share/dict/words crtdir
	cp $< ./data/$@

crtdir:
	rm -rf data plots
	mkdir data
	mkdir plots

#words.txt: crtdir
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "./data/words.txt", quiet = TRUE)'