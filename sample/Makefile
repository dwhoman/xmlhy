SHELL = /bin/sh
.SUFFIXES: .py .pyc .hy

%: %.hy
	hyc $<

all: atom_1 rss_1 svg_1 xcard_1 xhtml_1 xmlhy_1

.SECONDEXPANSION:
atom_1: $$@.hy
rss_1: $$@.hy
svg_1: $$@.hy
xcard_1: $$@.hy
xhtml_1: $$@.hy
xmlhy_1: $$@.hy

clean:
	-rm -f *.pyc
