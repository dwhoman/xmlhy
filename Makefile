all:
	cd xmlgen && $(MAKE)
	cd ..
	-ln -s xmlgen/xmlgen_helpers.pyc xmlgen_helpers.pyc
