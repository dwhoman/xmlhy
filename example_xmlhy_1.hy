(import [xmlhy.xmlhy :as x] [sys])
(require xmlhy.xmlhy)
(def xmlhy-buffer sys.--stdout--)
(xmlhy-declare "1.0")
(xmlhy-crlf)
(xmlhy "person" {"&ns" "p" "xmlns:p" "http://www.w3.org/TR/html4/"}
        (xmlhy-crlf)(xmlhy-tab)
        (xmlhy "name" {"&ns" "p"} "Bob")
        (xmlhy-crlf)(xmlhy-tab)
        (xmlhy "age" {"&ns" "p"} "42"))
(xmlhy-crlf)

