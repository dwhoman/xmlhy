.SUFFIXES: .py .pyc .hy

%: tests.hy
	hyc tests.hy
	hy tests.hy
	python tests.pyc
clean:
	-rm -f *.pyc
