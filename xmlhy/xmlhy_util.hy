(def double-quote False)
;;; double quotes will be used for XML attribute values if True; otherwise,
;;; single quotes will be used.

(defn concat [&rest elements]
  "Join all argument elements into a string."
  (.join "" elements))

(defn -ns-attributes [&kwargs attributes]
  "The `attributes' argument is a dictionary. The function returns a
  pair of strings; (xml namespace, attrib='val'...). The namespace
  value can be specified using the special key '&ns'. The namespace
  value must either be a string or sequence of strings. Namespace
  string sequences are joined together with colons. XML tag attributes
  must be strings."
  
  (let [[quote-char (if double-quote "\"" "'")]
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
                  (genexpr (concat (str k) "=" quote-char (str v) quote-char)
                           [(, k v) (.items attributes)]
                           (!= k "&ns")))]
          [True
           ""])]]
    (, namespace attribute-str)))

(defn begin-tag [element &kwargs attributes]
  "Create an XML beginning tag with the given attributes.

   element - The name of the element (string-able).

   attributes - Key value pairs that get turned into xml attributs.
                The special key &ns is used to set the element's
                namespace.  It is either a string of colon separated
                values, a list of string values.
"
  (let [[elt (str element)]
        [ns-atr (apply -ns-attributes [] attributes)]]
    (concat "<" (first ns-atr) elt " " (second ns-atr) ">")))

(defn end-tag [element &kwargs attributes]
  "Create an XML ending tag. `attributes' is used to specify the
  elements namespace. This fuction complements begin-tag."
  (let [[elt (str element)]
        [ns-atr (apply -ns-attributes [] attributes)]]
    (concat "</" (first ns-atr) elt ">")))

(defn text-tag [element text &kwargs attributes]
  "Create an xml leaf containing the specified text. This node cannot
  contain sub-trees. See begin-tag for more information."
  (concat (apply begin-tag [element] attributes)
          text
          (apply end-tag [element] attributes)))

(defn single-tag [element &kwargs attributes]
  "Create an xml tag without any child nodes, such as <br />. See
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
  the instruction's name, such as 'xml'. `attributes' is an
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



