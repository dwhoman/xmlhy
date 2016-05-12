SHELL = /bin/sh
.SUFFIXES: .py .pyc .hy

%: %.hy
	hyc $<

all: xmlgen_helpers xmlgen rss mathml atom svg xcard xhtml

.SECONDEXPANSION:
xmlgen_helpers: $$@.hy
xmlgen: $$@.hy
rss: $$@.hy
mathml: $$@.hy
atom: $$@.hy
svg: $$@.hy
xcard: $$@.hy
xhtml: $$@.hy

clean:
	-rm -f *.pyc
