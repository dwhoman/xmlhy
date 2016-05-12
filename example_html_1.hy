(import [xmlgen.xmlgen :as x]
        [xmlgen.xmlgen-helpers]
        [xmlgen.xhtml]
        [sys])

(require xmlgen.xmlgen)
(require xmlgen.xhtml)
(def xmlgen-buffer sys.--stdout--)
(xhtml-html
 (xhtml-head (xhtml-title "Sample xHTML"))
 (xmlgen-crlf)
 (xhtml-body (xhtml-h1 "Sample xHTML")
             (xhtml-div {"id" "lorem1500"}
                        (xhtml-p "Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
 enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
 ut aliquip ex ea commodo consequat. Duis aute irure dolor in
 reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
 pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
 culpa qui officia deserunt mollit anim id est laborum."))))
(xmlgen-crlf)
