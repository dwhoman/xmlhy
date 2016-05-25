.SUFFIXES: .py .pyc .hy
.PHONY: tests
tests: tests.hy
	hyc tests.hy
	hy tests.hy
	sleep 2
	python tests.pyc
clean:
	-rm -f *.pyc
