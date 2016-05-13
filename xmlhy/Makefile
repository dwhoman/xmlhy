SHELL = /bin/sh
.SUFFIXES: .py .pyc .hy

%: %.hy
	hyc $<

all: xmlhy_util xmlhy rss mathml atom svg xcard xhtml

.SECONDEXPANSION:
xmlhy_util: $$@.hy
xmlhy: $$@.hy
rss: $$@.hy
mathml: $$@.hy
atom: $$@.hy
svg: $$@.hy
xcard: $$@.hy
xhtml: $$@.hy

clean:
	-rm -f *.pyc
