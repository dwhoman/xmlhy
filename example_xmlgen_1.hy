(import [xmlgen.xmlgen :as x] [sys])
(require xmlgen.xmlgen)
(def xmlgen-buffer sys.--stdout--)
(xmlgen-declare "1.0")
(xmlgen-crlf)
(xmlgen "person" {"&ns" "p" "xmlns:p" "http://www.w3.org/TR/html4/"}
        (xmlgen-crlf)(xmlgen-tab)
        (xmlgen "name" {"&ns" "p"} "Bob")
        (xmlgen-crlf)(xmlgen-tab)
        (xmlgen "age" {"&ns" "p"} "42"))
(xmlgen-crlf)

