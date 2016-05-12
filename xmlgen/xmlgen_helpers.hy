(defn concat [&rest elements]
  (.join "" (filter (lambda [x] (and x (not (none? x))
                                     (not (and (iterable? x)
                                               (or (empty? x) (nil? x))))))
                    elements)))

(defn -ns-attributes [&kwargs attributes]
  "Returns two strings; namespace, attributes."
  (let [[ns (if (in "&ns" attributes)
                (get attributes "&ns")
                None)]
        [namespace
         (cond
          [(none? ns) ""]
          [(coll? ns)
           (concat (.join ":" (genexpr (str x) [x ns])) ":")]
          [True
           (let ((name (str ns)))
             (if (name.endswith ":")
               name
               (concat name ":")))])]
        [attribute-str
         (cond
          [(isinstance attributes dict)
           (.join " "
                  (genexpr (concat (str k) "='" (str v) "'") [(, k v) (.items attributes)] (!= k "&ns")))]
          [True
           ""])]]
    (, namespace attribute-str)))

(defn begin-tag [element &kwargs attributes]
  "Convert a sexp to xml. The user must ensure escapes are done.

   element - The name of the element (string-able).

   attributes - Key value pairs that get turned into xml attributs.
                Special attribute &ns - The element namespace.  It is
                either a string of colon separated values, a list of
                string values.
"
  (let [[elt (str element)]
        [ns-atr (apply -ns-attributes [] attributes)]]
    (concat "<" (get ns-atr 0) elt " " (get ns-atr 1) ">")))

(defn end-tag [element &kwargs attributes]
  (let [[elt (str element)]
        [ns-atr (apply -ns-attributes [] attributes)]]
    (concat "</" (get ns-atr 0) elt ">")))

(defn text-tag [element text &kwargs attributes]
  "Create an xml leaf containing the specified text. This node cannot
  contain sub-trees."
  (concat (apply begin-tag [element] attributes)
          text
          (apply end-tag [element] attributes)))

(defn single-tag [element &kwargs attributes]
  (let [[elt (str element)]
        (ns-atr (apply -ns-attributes [] attributes))]
    (concat "<" (get ns-atr 0) elt " " (get ns-atr 1) "/>")))

(defn print-to-buffer [the-string &optional [buffer None]]
  (if buffer
    (print the-string :end "" :file buffer)
    (print the-string :end "")))

(defn xml-instruction [&rest attributes]
  (let [[result ["<?"]]]
    (.append result (car attributes))
    (.append result " ")
    (for [pair (rest attributes)]
      (.append result (car pair))
      (.append result "='")
      (.append result (second pair))
      (.append result "'"))
    (.append result "?>")
    (apply concat result)))

(defmain [&rest args]

  (defclass WritableObject []
    [[--init-- (fn [self]
                 (setv self.content [])
                 None)]
     [write (fn [self string]
              (self.content.append string))]])
  (let ((output (WritableObject)))
    
    (print-to-buffer (apply begin-tag ["tag"] {";ns" None}) output)
    (print-to-buffer (apply end-tag ["tag"] {";ns" None}) output)
    (print-to-buffer (concat "a" "b" None) output)
    (print-to-buffer (concat "" None) output)
    (print output.content)))



