all:: zip

1:: docs/e1/cover.tex docs/e1/modelo.pdf
	(cd docs/e1 && pdflatex cover.tex && pdfunite cover.pdf modelo.pdf delivery-01-64.pdf)

2:: docs/e2/relatorio.tex
	(cd docs/e2 && pdflatex relatorio.tex && mv relatorio.pdf delivery-02-64.pdf)

3:: docs/e3/relatorio.tex
	(cd docs/e3 && pdflatex relatorio.tex && mv relatorio.pdf 64-relatorio.pdf)

clean::
	(rm -f docs/e1/delivery-01-64.pdf docs/e1/cover.pdf docs/e2/delivery-02-64.pdf docs/e3/64-relatorio.pdf entregay-03-64.zip && find . | egrep '*.aux|*.log|*.nav|*.out|*.snm|*.toc' | grep -v "git" | xargs \rm -f)

zip:: 3
	(zip -j entregay-03-64.zip docs/e3/64-relatorio.pdf src/*.sql && cd src/ && zip -r ../entregay-03-64 web)
