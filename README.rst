1 xmlhy
-------

xmlhy is a hy library that provides macros and functions for
generating xml. xmlhy uses macros to generate print statements for
producing xml.

1.1 Usage
~~~~~~~~~

xmlhy macros print to a buffer specified by the free variable
\`xmlhy-buffer', so before calling the result of an xmlhy macro, the
xmlhy-buffer variable \`xmlhy-buffer' must be set. xmlhy provides a
print buffer class named WritableObject. The value of
\`xmlhy-buffer' can be set to a WritableObject instance.
WritableObject stores print's output in a list, named content. To
print directly to the screen, set \`xmlhy-buffer' to sys.--stdout--.
The output is not formatted, save for explicit newlines, tabs, and
spaces.  The output can be piped into another program such as
xmlstarlet's \`xml fo'.

1.1.1 xmlhy
^^^^^^^^^^^

xmlhy is the main xml generating macro.  The xmlhy macro requires
a node name. Optionally, it can be given a dictionary of node
attributes and then a text string or one or more expressions for
the body.

.. code-block:: hy

    (xmlhy "name" {attributes}? body*)

The attribute dictionary can also be used to specify the tag's
name-space by using the key "&ns". The namespace value can be a
string or a list of strings.

.. code-block:: hy

    (xmlhy "node")

becomes

.. code-block:: html

    <node />

.. code-block:: hy

    (xmlhy "node" {})

becomes

.. code-block:: html

    <node />

.. code-block:: hy

    (xmlhy "node" {"&ns" "n"})

becomes

.. code-block:: html

    <n:node />

.. code-block:: hy

    (xmlhy "node" {"&ns" ["n" "x"]})

becomes

.. code-block:: html

    <n:x:node />

.. code-block:: hy

    (xmlhy "node" {"&ns" ["n" "x"]} "")

becomes

.. code-block:: html

    <n:x:node ></n:x:node>

.. code-block:: hy

    (xmlhy "node" {"&ns" ["n" "x"] "attrib" "val"} "Text node.")

becomes

.. code-block:: html

    <n:x:node attrib='val'>Text node.</n:x:node>

.. code-block:: hy

    (xmlhy "node" {"attrib" "val"} (xmlhy "a") (xmlhy "b" "Text"))

becomes

.. code-block:: html

    <node attrib='val'><a /><b >Text</b></node>

Attribute values are single quoted by default, but double quotes
can be produced by setting the &dq attribute.

.. code-block:: hy

    (xmlhy "node" {"&dq" True "attrib" "val"} (xmlhy "a") (xmlhy "b" "Text"))

becomes

.. code-block:: html

    <node attrib="val"><a /><b >Text</b></node>

Mixing text and tags is not allowed, so

.. code-block:: hy

    (xmlhy "node" {"attrib" "val"} "a" (xmlhy "b"))

will not produce the likely desired output.

.. code-block:: html

    <node attrib='val'>a<b /></node>

is invalid XML. In this case, the latter nodes will be ignored. If
a tag is the first body argument, then all subsequent strings
are ignored; and if a string is the first body argument, then the
rest of the &rest arguments are ignored.

1.1.2 sanitize
^^^^^^^^^^^^^^

A non-destructive function for replacing <>"'& string characters
with there XML names.

1.1.3 xmlhy-comment
^^^^^^^^^^^^^^^^^^^

xmlhy-comment generates XML comments. This can be used for
creating Internet Explorer conditional statements. Similar to
xmlhy, it can take either or string or one or more lisp statements.

1.1.4 xmlhy-print
^^^^^^^^^^^^^^^^^

Used for printing dynamically generated strings to
xmlhy-buffer. Takes a lisp expression that evaluates to a string.

1.1.5 newlines, tabs, and spaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

xmlhy-crlf, xmlhy-tab, and xmlhy-space are used to generate print
statements to produce newlines, tabs, and spaces respectively,
which can be used for adding meaningful white-space between XML
tags. These functions take a single, optional natural number
argument specifying how many newlines, tabs, or spaces to print.

1.1.6 xml instructions
^^^^^^^^^^^^^^^^^^^^^^

The xmlhy module provides the macro, xmlhy-declare, for creating an
xml declaration statement, and the macro, xmlhy-stylesheet, for
creating xml stylesheet statements.

.. code-block:: hy

    (xmlhy-declare "1.0" "utf-8" True)

will print

.. code-block:: html

    <?xml version='1.0' encoding='utf-8' standalone='yes'?>

1.2 Creating tags
~~~~~~~~~~~~~~~~~

xmlhy.hy provides the macro generating macro \`xmlhy-tag' to easily
create new tags.

The expression

.. code-block:: hy

    (xmlhy-tag xhtml-html)

evaluates to

.. code-block:: hy

    (defmacro xhtml-html [&rest body]
      `(xmlhy "html" ~@(list body)))

1.3 XML element families
~~~~~~~~~~~~~~~~~~~~~~~~

xmlhy comes packaged with tag tables for atom, mathml, rss, svg,
util, xcard, and xhtml.

1.4 Installation
~~~~~~~~~~~~~~~~

To install on the machine, run \`make install'.

To install in a test environment, follow the procedures similar to
`http://docs.hylang.org/en/stable/hacking.html <http://docs.hylang.org/en/stable/hacking.html>`_.

1. Create a virtual environment:

   .. code-block:: sh

       virtualenv venv

   and activate it:

   .. code-block:: sh

       . venv/bin/activate

2. Install for testing:

   .. code-block:: sh

       cd xmlhy/
       make install

