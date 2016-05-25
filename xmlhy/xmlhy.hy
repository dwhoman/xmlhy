(import [xmlhy.util] [sys [--stderr--]])

;; Generates print statements that return xml tags with the tag NAME.
;; CONTENTS is broken down into an `attributes' dictionary and `body'
;; content to go in between the tags. The tag's namespace can be
;; specified using the special key, "&ns", in the attributes
;; dictionary. If the body is None or not specified, then a single
;; print statement, printing an empty tag, is produced. The free
;; variable `xmlhy-buffer' must be set, specifying the print
;; statement's print file.
(defmacro xmlhy [name &rest contents]
  (let [[attributes {}]
        [body contents]
        [helper (gensym)]
        [ename (gensym)]]
    (when (and (< 0 (len contents))
               (or (instance? hy.models.dict.HyDict (first contents))
                   (instance? dict (first contents))))
      (setv attributes (car contents))
      (setv body (cdr contents))) ; `rest' produces TypeError("object of type 'itertools.islice' has no len()",)
    ;; check body types, sanity check during compilation
    (when (< 0 (len body))
      (if (string? (first body))
        (when (< 1 (len body))
          (print (% "xmlhy ignoring contents for %s" name) :file --stderr--))
        (when (some string? body)
          (print (% "xmlhy ignoring string contents for %s" name) :file --stderr--))))
    (cond
     [(empty? body)            ; explicity none, <foo />
      `(do
        (import [xmlhy.util :as ~helper])
        (.print-to-buffer ~helper (apply (. ~helper single-tag) [~name] ~attributes) xmlhy-buffer))]
     [(and (< 0 (len body)) (string? (first body)))
      `(do ; text tag
        (import [xmlhy.util :as ~helper])
        (.print-to-buffer ~helper
         (apply (. ~helper text-tag) [~name ~(first body)] ~attributes) xmlhy-buffer))]
     [True                     ; has child nodes
      `(let [[~ename ~name]]   ; in case name is a stateful expression
        (import [xmlhy.util :as ~helper])
        (.print-to-buffer ~helper
         (apply (. ~helper begin-tag) [~ename] ~attributes) xmlhy-buffer)
        ~@(list body)
        (.print-to-buffer ~helper (apply (. ~helper end-tag) [~ename] ~attributes) xmlhy-buffer))])))

;;; macro for defining new xml tag functions

;;; (xmlhy-tag html-html) will create a macro (html-html) that will
;;; output <html/> type tags. Dashes will be preserved but underscores
;;; will be converted to dashes, since Hy converts dashes to
;;; underscores in non-strings. So if you want an underscore, use an
;;; ampersand. So a-b-c and a_b_c become the macro a-b-c or a_b_c and
;;; prints the tag b-c.  Similarly, a-b&c become the macro a-b&c and
;;; prints b_c.
(defmacro xmlhy-tag [tag-ns-name]
  (with-gensyms [name replace]
    `(defmacro ~tag-ns-name [&rest body]
       ;; functions will not exist at run-time
       (defn ~tag-ns-name [])
       ;; attempted to move ~replace to xmlhy.util but had referencing
       ;; problems, having it here only adds to compile time; no need
       ;; to factor out
       (defn ~replace [string]
         (let [[result []]]
           (for [c string]
             (cond
              [(= c "_") (.append result "-")]
              [(= c "&") (.append result "_")]
              [True (.append result c)]))
           (.join "" result)))
       (let [[~name (->
                     (.split (. ~tag-ns-name --name--) "_" 1)
                     (last)
                     (~replace))]]
         `(xmlhy ~~name ~@(list body))))))

(defn sanitize [string]
  """Return a string with <>\"'& characters escaped."""
  (let [[result []]]
    (for [c string]
      (cond       
       [(= c "&" ) (.append result "&amp;")]
       [(= c "'" ) (.append result "&apos;")]
       [(= c "\"") (.append result "&quot;")]
       [(= c "<" ) (.append result "&lt;")]
       [(= c ">" ) (.append result "&gt;")]
       [True (.append result c)]))
    (.join "" result)))

;;; Similar to xmlhy. The user might want to create IE conditional
;;; comments or some other commented xml.
(defmacro xmlhy-comment [&rest content]
  ;; check content types
  (when (< 0 (len content))
    (if (string? (first content))
      (when (< 1 (len content))
        (print "xmlhy ignoring contents for comment" :file --stderr--))
      (when (some string? content)
        (print "xmlhy ignoring string contents for comment" :file --stderr--))))
  (with-gensyms [helper]
    (cond
     [(empty? content)
      `(do
        (string? "")           ; hack
        (import [xmlhy.util :as ~helper])
        (.print-to-buffer ~helper "<!--  -->" xmlhy-buffer))]
     [(and (< 0 (len content)) (string? (first content)))
      `(do
        (string? "")           ; hack
        (import [xmlhy.util :as ~helper])
        (.print-to-buffer ~helper (.concat ~helper "<!--" ~(first content) "-->") xmlhy-buffer))]
     [True
      `(do
        (string? "")           ; hack
        (import [xmlhy.util :as ~helper])
        (.print-to-buffer ~helper "<!--" xmlhy-buffer)
        ~@(list content)
        (.print-to-buffer ~helper "-->" xmlhy-buffer))])))

;;; Used for printing dynamically created strings. Should not be used
;;; for mixing tags and strings.
(defmacro xmlhy-print [to-print]
  (with-gensyms [helper]
    `(do
      (string? "")           ; hack
      (import [xmlhy.util :as ~helper])
      (.print-to-buffer ~helper ~to-print xmlhy-buffer))))

;;; White space is meaningful in XML.
(defmacro xmlhy-crlf [&optional [spaces '1]]
  (with-gensyms [helper]
    `(do
      (string? "")           ; hack
      (import [xmlhy.util :as ~helper])
      (.print-to-buffer ~helper (* "\n" (int ~spaces)) xmlhy-buffer))))

(defmacro xmlhy-tab [&optional [tabs '1]]
  (with-gensyms [helper]
    `(do
      (string? "")           ; hack
      (import [xmlhy.util :as ~helper])
      (.print-to-buffer ~helper (* "\t" (int ~tabs)) xmlhy-buffer))))

(defmacro xmlhy-space [&optional [spaces '1]]
  (with-gensyms [helper]
    `(do
      (string? "")           ; hack
      (import [xmlhy.util :as ~helper])
      (.print-to-buffer ~helper (* " " (int ~spaces)) xmlhy-buffer))))

;;; Create an xml declaration statement. VERSION is an XML version
;;; string, usually '1.0' or '1.1'. ENCODING is a string. STANDALONE
;;; is a boolean. Prints to xmlhy-buffer.  None can be used for any
;;; parameter, None parameters will not be included.
(defmacro xmlhy-declare [version &optional [encoding 'nil] [standalone 'nil]]
  (with-gensyms [g-version g-encoding g-standalone helper args]
    `(let [[~g-encoding ~encoding]
           [~g-standalone ~standalone]
           [~args ["xml" (, "version" (str ~version))]]]
       (when (string? ~g-encoding)
         (.append ~args (, "encoding" ~g-encoding)))
       (when (instance? bool ~g-standalone)
         (.append ~args (, "standalone" (if (= ~True ~g-standalone) "yes" "no"))))
       (import [xmlhy.util :as ~helper])
       (.print-to-buffer ~helper (apply (. ~helper xml-instruction) ~args) xmlhy-buffer))))

;;; Create <?xml-stylesheet?>. href, type, title, media, and charset
;;; are strings.  alternate is a boolean.  None can be used for any
;;; parameter, None parameters will not be included.
(defmacro xmlhy-stylesheet [&optional [href 'nil] [type 'nil] [title 'nil] [media 'nil] [charset 'nil] [alternate 'nil]]
  (with-gensyms [g-href g-type g-title g-media g-charset g-alternate helper args]
    `(let [[~g-href ~href]
           [~g-type ~type]
           [~g-title ~title]
           [~g-media ~media]
           [~g-charset ~charset]
           [~g-alternate ~alternate]
           [~args ["xml-stylesheet"]]]
       (when (string? ~g-href)
         (.append ~args (, "href" ~g-href)))
       (when (string? ~g-type)
         (.append ~args (, "type" ~g-type)))
       (when (string? ~g-title)
         (.append ~args (, "title" ~g-title)))
       (when (string? ~g-media)
         (.append ~args (, "media" ~g-media)))
       (when (string? ~g-charset)
         (.append ~args (, "charset" ~g-charset)))
       (when (instance? bool ~g-alternate)
         (.append ~args (, "alternate" (if (= ~True ~g-href) "yes" "no"))))
       (import [xmlhy.util :as ~helper])
       (.print-to-buffer ~helper (apply (. ~helper xml-instruction) ~args) xmlhy-buffer))))

(defclass WritableObject []
  "Buffer that print can be redirected to. The print output is stored
  in its `content' variable."
  
  [[--init-- (fn [self]
               (setv self.content [])
               None)]
   [write (fn [self string]     ;required by print
            "Append element `string' to self.content."
            (self.content.append string))]
   [concat (fn [self &optional [join-str ""]]
             "Join WritableObject's contents separated by `join-str'."
             (join-str.join self.content))]])
