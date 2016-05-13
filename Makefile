all:
	cd xmlhy && $(MAKE)
	cd ..
	if ! $$(test -f xmlhy_util.pyc);\
	then ln -s xmlhy/xmlhy_util.pyc xmlhy_util.pyc; fi
#	if ! $$(test -f xmlhy.pyc);\
	then ln -s xmlhy/xmlhy.pyc xmlhy.pyc; fi
#	if ! $$(test -f xhtml.pyc);\
	then ln -s xmlhy/xhtml.pyc xhtml.pyc; fi
%:
	cd xmlhy && $(MAKE) $*

clean:
	-rm -f *.pyc
	cd xmlhy && $(MAKE) clean
