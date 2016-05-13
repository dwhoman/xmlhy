(import [xmlhy :as x]
        [xmlhy-util]
        [xhtml]
        [sys])

(require xmlhy)
(require xhtml)
(def xmlhy-buffer sys.--stdout--)
(setv xmlhy-util.double-quote True)
(xhtml-html
 (xhtml-head (xhtml-title "Sample xHTML"))
 (xmlhy-crlf)
 (xhtml-body (xhtml-h1 "Sample xHTML")
             (xhtml-div {"id" "lorem1500"}
                        (xhtml-p "Lorem ipsum dolor sit amet, consectetur adipiscing elit,
 sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
 enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
 ut aliquip ex ea commodo consequat. Duis aute irure dolor in
 reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
 pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
 culpa qui officia deserunt mollit anim id est laborum."))))
(xmlhy-crlf)
