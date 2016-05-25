SHELL = /bin/sh
.SUFFIXES: .py .pyc .hy

%: %.hy
	hyc $<

all: example_atom_1 example_rss_1 example_svg example_xcard_1 example_xhtml_1 example_xhtml_2 example_xmlhy_1

.SECONDEXPANSION:
example_atom_1: $$@.hy
example_rss_1: $$@.hy
example_svg: $$@.hy
example_xcard_1: $$@.hy
example_xhtml_1: $$@.hy
example_xhtml_2: $$@.hy
example_xmlhy_1: $$@.hy

clean:
	-rm -f *.pyc
