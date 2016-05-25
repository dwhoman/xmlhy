(defn concat [&rest elements]
  "Join all argument elements into a string, without separation."
  (.join "" elements))

(defn -ns-attributes [&kwargs attributes]
  "Separate XML attribuets from special attributes, namespace and
  double-quote.  Returns a pair of strings; ('XML namespace',
  \"attrib='val'...\"), where 'val' is \"val\" if '&dq' is a non-null
  keyword argument. The namespace value can be specified using the
  '&ns' keyword. The namespace value must either be a single value or
  a sequence of values. Namespace sequences are stringified and joined
  together with colons.  The user can also override the quoting
  behavior by adding quoting characters arround the attribute value,
  e.g. '\\\"name\\\"' will print `name' in double quotes even if &dq
  is not set."

  (let [[quote-char (if (and (in "&dq" attributes) (get attributes "&dq"))
                      "\""
                      "'")]
        [ns (if (in "&ns" attributes)
              (get attributes "&ns")
              None)]
        [namespace
         (cond
          [(none? ns) ""]
          [(coll? ns)
           (concat (.join ":" (genexpr (str x) [x ns])) ":")]
          [True
           (let [[name (str ns)]]
             (if (name.endswith ":")
               name
               (concat name ":")))])]
        [attribute-str
         (cond
          [(instance? dict attributes)
           ;; join non-namespace key value pairs into key='value'
           ;; strings and then join the resulting strings
           (.join " "
                  (genexpr (concat (str k) "="
                                   (if (and (string? v)
                                            (or (and (= "\"" (first v))
                                                     (= "\"" (last v)))
                                                (and (= "'" (first v))
                                                     (= "'" (last v)))))
                                     v
                                     (concat
                                      quote-char
                                      (str v)
                                      quote-char)))
                           [(, k v) (.items attributes)]
                           (and (!= k "&ns")
                                (!= k "&dq"))))]
          [True
           ""])]]
    (, namespace attribute-str)))

(defn begin-tag [element &kwargs attributes]
  "Create an XML beginning tag with the given attributes.

   element - The element name.

   attributes - Key value pairs that get turned into XML attributes.
                The special key, &ns, is used to set the element's
                namespace.  It is either a value, a string of colon
                separated values, a list of values. The setting the
                special key, &dq, to non-null causes attributes to be
                double quoted.
"
  (let [[elt (str element)]
        [ns-atr (apply -ns-attributes [] attributes)]]
    (concat "<" (first ns-atr) elt " " (second ns-atr) ">")))

(defn end-tag [element &kwargs attributes]
  "Create an XML ending tag. `attributes' is used to specify the
  elements namespace. This function complements begin-tag."
  (let [[elt (str element)]
        [ns-atr (apply -ns-attributes [] attributes)]]
    (concat "</" (first ns-atr) elt ">")))

(defn text-tag [element text &kwargs attributes]
  "Create an XML leaf containing the specified text. This node cannot
  contain sub-trees. See begin-tag for more information."
  (concat (apply begin-tag [element] attributes)
          text
          (apply end-tag [element] attributes)))

(defn single-tag [element &kwargs attributes]
  "Create an XML tag without any child nodes, such as <br />. See
  begin-tag for more information."
  (let [[elt (str element)]
        (ns-atr (apply -ns-attributes [] attributes))]
    (concat "<" (first ns-atr) elt " " (second ns-atr) "/>")))

(defn print-to-buffer [the-string &optional [buffer None]]
  "Print the given string to the specified buffer without adding a
  newline. If buffer is not specified, it is the same as running print
  without :file specified and with :end set to the empty string."
  (if buffer
    (print the-string :end "" :file buffer)
    (print the-string :end "")))

(defn xml-instruction [name &rest attributes]
  "Create an XML instruction such as <?xml version='1.0'?>. `name' is
  the instruction's name, such as 'XML'. `attributes' is an
  association list of label, value pairs."
  ;; using an association list to make testing easier; keep ordering consistent
  (let [[result ["<?" name]]]
    (for [pair attributes]
      (.append result " ")
      (.append result (first pair))
      (.append result "='")
      (.append result (second pair))
      (.append result "'"))
    (.append result "?>")
    (apply concat result)))
