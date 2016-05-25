.PHONY: tests clean install sample
install: setup.py
	pip install .
tests:
	cd tests && $(MAKE) tests
sample:
	cd sample && $(MAKE)
clean:
	-rm -f *.pyc
	-rm -rf build
	-rm -rf dist
	-rm -rf xmlhy.egg-info
	cd tests && $(MAKE) clean
	cd ..
	cd sample && $(MAKE) clean
