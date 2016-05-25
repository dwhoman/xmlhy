install: setup.py
	python setup.py install --user
tests:
	cd tests && $(MAKE)
samples:
	cd sample && $(MAKE)
clean:
	-rm -f *.pyc
	-rm -rf build
	-rm -rf xmlhy.egg-info
	cd tests && $(MAKE) clean
	cd ..
	cd sample && $(MAKE) clean
