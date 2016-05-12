(import [xmlgen-helpers] [sys])

;; Generates print statements that return xml tags with the tag NAME
;; and ATTRIBUTES. The body is inserted in between the print
;; statements. ATTRIBUTES is a dictionary. The namespace can be
;; specified using the special key, "&ns", in ATTRIBUTES. If the body
;; is empty, none or not specified, then a single print statement,
;; printing an empty tag, is produced. This is an anaphoric macro; the
;; variable `xmlgen-buffer' must be set, specifying the print
;; statement's print file.
(defmacro xmlgen [name &rest contents]
  (let [[helper (gensym)]
        [attributes {}]
        [body contents]
        [ename (gensym)]]
    (when (and (< 0 (len contents))
               (or (isinstance (get contents 0) hy.models.dict.HyDict)
                   (isinstance (get contents 0) dict)))
      (do
       (setv attributes (get contents 0))
       (setv body (slice contents 1))))
    ;; check body types
    (when (< 0 (len body))
      (if (isinstance (get body 0) str)
        (when (< 1 (len body))
          (print (% "xmlgen ignoring contents for %s" name) :file sys.--stderr--))
        (when (some string? body)
          (print (% "xmlgen ignoring string contents for %s" name) :file sys.--stderr--))))
    (cond
     [(empty? body)            ;explicity none, <foo />
      `(do
        (import [xmlgen-helpers :as ~helper])
        ((. ~helper print-to-buffer) (apply (. ~helper single-tag) [~name] ~attributes) xmlgen-buffer))]
     [(and (< 0 (len body)) (isinstance (get body 0) str))
      `(do ; text tag
        (import [xmlgen-helpers :as ~helper])
        ((. ~helper print-to-buffer)
         (apply (. ~helper text-tag) [~name ~(get body 0)] ~attributes) xmlgen-buffer))]
     [True                     ;has child nodes
      `(let [[~ename ~name]]   ;in case name is a stateful expression
        (import [xmlgen-helpers :as ~helper])
        ((. ~helper print-to-buffer)
         (apply (. ~helper begin-tag) [~ename] ~attributes) xmlgen-buffer)
        ~@(list body)
        ((. ~helper print-to-buffer) (apply (. ~helper end-tag) [~ename] ~attributes) xmlgen-buffer))])))

;;; macro for defining new xml tag functions

;;; (xmlgen-tag html-html) will create a macro (html-html) that will
;;; output <html/> type tags. 
(defmacro xmlgen-tag [tag-ns-name]
  (with-gensyms [name]
    `(defmacro ~tag-ns-name [&rest body]
       (defun ~tag-ns-name [])
       (let [[~name (last (.split (. ~tag-ns-name --name--) "_" 1))]]
         `(xmlgen ~~name ~@(list body))))))

(defn sanitize [string]
  """Return a string with <>\"'& characters escaped."""
  (defn replace [string old new]
    (string.replace old new))
  (-> (replace string "&" "&amp;")
      (replace "'" "&apos;")
      (replace "\"" "&quot;")
      (replace "<" "&lt;")
      (replace ">" "&gt;")))

;; Create an xml declaration statement. VERSION is an XML version
;; string, usually '1.0' or '1.1'. ENCODING is a string. STANDALONE is
;; a boolean. Prints to xmlgen-buffer.
(defmacro xmlgen-declare [version &optional [encoding 'nil] [standalone 'nil]]
  ;; guard against bug: AttributeError: 'NoneType' object has no attribute 'replace'
  (with-gensyms [g-version g-encoding g-standalone helper args]
    `(let [[~g-encoding ~encoding]
           [~g-standalone ~standalone]
           [~args ["xml" (, "version" (str ~version))]]]
       (when (isinstance ~g-encoding str)
         (.append ~args (, "encoding" ~g-encoding)))
       (when (isinstance ~g-standalone bool)
         (.append ~args (, "standalone" (if (= ~True ~g-standalone) "yes" "no"))))
       (import [xmlgen-helpers :as ~helper])
       ((. ~helper print-to-buffer) (apply (. ~helper xml-instruction) ~args) xmlgen-buffer))))

(defmacro xmlgen-comment [&rest content]
  ;; check content types
  (when (< 0 (len content))
    (if (isinstance (get content 0) str)
      (when (< 1 (len content))
        (print "xmlgen ignoring contents for comment"))
      (when (some string? content)
        (print "xmlgen ignoring string contents for comment"))))
  (with-gensyms [helper]
    (cond
     [(empty? content)
      `(do
        (import [xmlgen-helpers :as ~helper])
        (.print-to-buffer ~helper "<!--  -->" xmlgen-buffer))]
     [(and (< 0 (len content)) (isinstance (get content 0) str))
      `(do
        (import [xmlgen-helpers :as ~helper])
        (.print-to-buffer ~helper (.concat ~helper "<!--" ~(get content 0) "-->") xmlgen-buffer))]
     [True
      `(do
        (import [xmlgen-helpers :as ~helper])
        (.print-to-buffer ~helper "<!--" xmlgen-buffer)
        ~@(list content)
        (.print-to-buffer ~helper "-->" xmlgen-buffer))])))

;;; Used for printing dynamically created strings. Should not be used
;;; for mixing tags and strings.
(defmacro xmlgen-print [to-print]
  (with-gensyms [helper]
    `(do
      (import [xmlgen-helpers :as ~helper])
      ((. ~helper print-to-buffer) ~to-print xmlgen-buffer))))

;;; white space is meaningful in XML
(defmacro xmlgen-crlf [&optional [spaces '1]]
  (with-gensyms [helper]
    `(do
      (import [xmlgen-helpers :as ~helper])
      (.print-to-buffer ~helper (* "\n" (int ~spaces)) xmlgen-buffer))))

(defmacro xmlgen-tab [&optional [tabs '1]]
  (with-gensyms [helper]
    `(do
      (import [xmlgen-helpers :as ~helper])
      (.print-to-buffer ~helper (* "\t" (int ~tabs)) xmlgen-buffer))))

(defmacro xmlgen-space [&optional [spaces '1]]
  (with-gensyms [helper]
    `(do
      (import [xmlgen-helpers :as ~helper])
      (.print-to-buffer ~helper (* " " (int ~spaces)) xmlgen-buffer))))

;;; Create <?xml-stylesheet?>
;;; href, type, title, media, and charset are strings
;;; alternate is a boolean
;;; None can be used for any parameter, none parameters will not be included.
(defmacro xmlgen-stylesheet [&optional [href 'nil] [type 'nil] [title 'nil] [media 'nil] [charset 'nil] [alternate 'nil]]
  (with-gensyms [g-href g-type g-title g-media g-charset g-alternate helper args]
    `(let [[~g-href ~href]
           [~g-type ~type]
           [~g-title ~title]
           [~g-media ~media]
           [~g-charset ~charset]
           [~g-alternate ~alternate]
           [~args ["xml-stylesheet"]]]
       (when (isinstance ~g-href str)
         (.append ~args (, "href" ~g-href)))
       (when (isinstance ~g-type str)
         (.append ~args (, "type" ~g-type)))
       (when (isinstance ~g-title str)
         (.append ~args (, "title" ~g-title)))
       (when (isinstance ~g-media str)
         (.append ~args (, "media" ~g-media)))
       (when (isinstance ~g-charset str)
         (.append ~args (, "charset" ~g-charset)))
       (when (isinstance ~g-alternate bool)
         (.append ~args (, "alternate" (if (= ~True ~g-href) "yes" "no"))))
       (import [xmlgen-helpers :as ~helper])
       ((. ~helper print-to-buffer) (apply (. ~helper xml-instruction) ~args) xmlgen-buffer))))

;;; TODO DTD, maybe?

(defclass WritableObject []
  "Buffer that print can be redirected to print to. The print output
  is stored in its CONTENT variable."

  [[--init-- (fn [self]
               (setv self.content [])
               None)]
   [write (fn [self string]     ;required by print
          "Append element STRING to self.content."
          (self.content.append string))]
   [concat (fn [self &optional [join-str ""]]
             "Concatenate WritableObject's contents using JOIN-STR."
             (join-str.join self.content))]])

(def *exports*
  '[xmlgen xmlgen-tag sanitize xmlgen-declare
    xmlgen-comment xmlgen-crlf xmlgen-tab
    xmlgen-space xmlgen-stylesheet WritableObject])
