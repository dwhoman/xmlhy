(import [xmlgen-helpers] [xmlgen])

(require xmlgen)
;;; html
(defmacro xhtml-html [&rest body]
  `(xmlgen "html" ~@(list body)))
(defmacro xhtml-body [&rest body]
  `(xmlgen "body" ~@(list body)))
(defmacro xhtml-head [&rest body]
  `(xmlgen "head" ~@(list body)))
(defmacro xhtml-base [&rest body]
  `(xmlgen "base" ~@(list body)))
(defmacro xhtml-style [&rest body]
  `(xmlgen "style" ~@(list body)))
(defmacro xhtml-title [&rest body]
  `(xmlgen "title" ~@(list body)))
(defmacro xhtml-address [&rest body]
  `(xmlgen "address" ~@(list body)))
(defmacro xhtml-link [&rest body]
  `(xmlgen "link" ~@(list body)))
(defmacro xhtml-h1 [&rest body]
  `(xmlgen "h1" ~@(list body)))
(defmacro xhtml-h2 [&rest body]
  `(xmlgen "h2" ~@(list body)))
(defmacro xhtml-h3 [&rest body]
  `(xmlgen "h3" ~@(list body)))
(defmacro xhtml-h4 [&rest body]
  `(xmlgen "h4" ~@(list body)))
(defmacro xhtml-h5 [&rest body]
  `(xmlgen "h5" ~@(list body)))
(defmacro xhtml-h6 [&rest body]
  `(xmlgen "h6" ~@(list body)))
(defmacro xhtml-p [&rest body]
  `(xmlgen "p" ~@(list body)))
(defmacro xhtml-br [&optional [options {}]]
  `(xmlgen "br" ~options))
(defmacro xhtml-a [&rest body]
  `(xmlgen "a" ~@(list body)))
(defmacro xhtml-img [&rest body]
  `(xmlgen "img" ~@(list body)))
(defmacro xhtml-pre [&rest body]
  `(xmlgen "pre" ~@(list body)))
(defmacro xhtml-q [&rest body]
  `(xmlgen "q" ~@(list body)))
(defmacro xhtml-s [&rest body]
  `(xmlgen "s" ~@(list body)))
(defmacro xhtml-div [&rest body]
  `(xmlgen "div" ~@(list body)))
(defmacro xhtml-span [&rest body]
  `(xmlgen "span" ~@(list body)))
(defmacro xhtml-hr [&optional [options {}]]
  `(xmlgen "hr" ~options))
(defmacro xhtml-script [&rest body]
  `(xmlgen "script" ~@(list body)))

;;; form tags
(defmacro xhtml-button [&rest body]
  `(xmlgen "button" ~@(list body)))
(defmacro xhtml-datalist [&rest body]
  `(xmlgen "datalist" ~@(list body)))
(defmacro xhtml-fieldset [&rest body]
  `(xmlgen "fieldset" ~@(list body)))
(defmacro xhtml-form [&rest body]
  `(xmlgen "form" ~@(list body)))
(defmacro xhtml-input [&rest body]
  `(xmlgen "input" ~@(list body)))
(defmacro xhtml-keygen [&rest body]
  `(xmlgen "keygen" ~@(list body)))
(defmacro xhtml-label [&rest body]
  `(xmlgen "label" ~@(list body)))
(defmacro xhtml-legend [&rest body]
  `(xmlgen "legend" ~@(list body)))
(defmacro xhtml-meter [&rest body]
  `(xmlgen "meter" ~@(list body)))
(defmacro xhtml-optgroup [&rest body]
  `(xmlgen "optgroup" ~@(list body)))
(defmacro xhtml-option [&rest body]
  `(xmlgen "option" ~@(list body)))
(defmacro xhtml-output [&rest body]
  `(xmlgen "output" ~@(list body)))
(defmacro xhtml-progress [&rest body]
  `(xmlgen "progress" ~@(list body)))
(defmacro xhtml-select [&rest body]
  `(xmlgen "select" ~@(list body)))
(defmacro xhtml-textarea [&rest body]
  `(xmlgen "textarea" ~@(list body)))

;;; list tags
(defmacro xhtml-ul [&rest body]
  `(xmlgen "ul" ~@(list body)))
(defmacro xhtml-ol [&rest body]
  `(xmlgen "ol" ~@(list body)))
(defmacro xhtml-li [&rest body]
  `(xmlgen "li" ~@(list body)))
(defmacro xhtml-dd [&rest body]
  `(xmlgen "dd" ~@(list body)))
(defmacro xhtml-dl [&rest body]
  `(xmlgen "dl" ~@(list body)))
(defmacro xhtml-dt [&rest body]
  `(xmlgen "dt" ~@(list body)))
;;; table tags
(defmacro xhtml-caption [&rest body]
  `(xmlgen "caption" ~@(list body)))
(defmacro xhtml-col [&rest body]
  `(xmlgen "col" ~@(list body)))
(defmacro xhtml-colgroup [&rest body]
  `(xmlgen "colgroup" ~@(list body)))
(defmacro xhtml-table [&rest body]
  `(xmlgen "table" ~@(list body)))
(defmacro xhtml-tbody [&rest body]
  `(xmlgen "tbody" ~@(list body)))
(defmacro xhtml-td [&rest body]
  `(xmlgen "td" ~@(list body)))
(defmacro xhtml-tfoot [&rest body]
  `(xmlgen "tfoot" ~@(list body)))
(defmacro xhtml-th [&rest body]
  `(xmlgen "th" ~@(list body)))
(defmacro xhtml-thead [&rest body]
  `(xmlgen "thead" ~@(list body)))
(defmacro xhtml-tr [&rest body]
  `(xmlgen "tr" ~@(list body)))

;;; html >5
(defmacro xhtml-hgroup [&rest body]
  `(xmlgen "hgroup" ~@(list body)))
;;; html 5+
(defmacro xhtml-header [&rest body]
  `(xmlgen "header" ~@(list body)))
(defmacro xhtml-footer [&rest body]
  `(xmlgen "footer" ~@(list body)))
(defmacro xhtml-nav [&rest body]
  `(xmlgen "nav" ~@(list body)))
(defmacro xhtml-section [&rest body]
  `(xmlgen "section" ~@(list body)))
(defmacro xhtml-article [&rest body]
  `(xmlgen "article" ~@(list body)))
(defmacro xhtml-figure [&rest body]
  `(xmlgen "figure" ~@(list body)))
(defmacro xhtml-figcaption [&rest body]
  `(xmlgen "figcaption" ~@(list body)))
(defmacro xhtml-main [&rest body]
  `(xmlgen "main" ~@(list body)))

(defmain [&rest args]
  (import sys)
  (setv xmlgen-buffer sys.--stdout--)
  (xhtml-html)
  (xhtml-body "")
  (xhtml-html "hello")
  (xhtml-html {})
  (xhtml-body {} "")
  (xhtml-html {} "hello")
  (xhtml-html {"class" "world" "id" "010"} "hello")
  (xhtml-html {"class" "world" "id" "011"}
             (xhtml-span {}
              "\n hello  ")
             (xhtml-html {"class" "world" "id" "012"}))
  (xhtml-br)
  (print ""))
