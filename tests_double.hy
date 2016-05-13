;; test double quoting
(import [xmlhy.xmlhy :as x]
        [sys]
        [unittest [TestCase]]
        [test.support [run_unittest]]
        [re])

(require xmlhy.xmlhy)

(defmacro test-tag [regex xmlhy-func]
  `(let [[xmlhy-buffer (x.WritableObject)]]
(import [xmlhy.xmlhy-util :as xh])
(setv xh.double-quote True)
     ~xmlhy-func
     (.assertTrue self
                  (.fullmatch (re.compile ~regex) (.concat xmlhy-buffer))
                  (+ "Got: " (.concat xmlhy-buffer)))))
(defclass Test [TestCase]
  [[test-lone-tag
    (fn [self]
      (test-tag "<a\s*/>" (xmlhy "a")))]
   [test-empty-string
    (fn [self]
      (test-tag "<a\s*></a>" (xmlhy "a" "")))]
   [test-string
    (fn [self]
      (test-tag "<a\s*>hello</a>" (xmlhy "a" "hello")))]
   [test-empty-attributes
    (fn [self]
      (test-tag "<a\s*/>" (xmlhy "a" {})))]
   [test-empty-attributes-and-empty-string
    (fn [self]
      (test-tag "<a\s*></a>" (xmlhy "a" {} "")))]
   [test-empty-attributes-and-string
    (fn [self]
      (test-tag "<a\s*>hello</a>" (xmlhy "a" {} "hello")))]
   [test-ns-and-string-1
    (fn [self]
      (test-tag "<b:a\s*>hello</b:a>" (xmlhy "a" {"&ns" "b"} "hello")))]
   [test-ns-and-string-2
    (fn [self]
      (test-tag "<b:c:a\s*>hello</b:c:a>" (xmlhy "a" {"&ns" "b:c"} "hello")))]
   [test-ns-and-string-3
    (fn [self]
      (test-tag "<b:c:a\s*>hello</b:c:a>" (xmlhy "a" {"&ns" ["b" "c"]} "hello")))]
   [test-ns-attributes-and-string
    (fn [self]
      (test-tag "<b:c:a\s+class=\"world\"\s*>hello</b:c:a>"
                (xmlhy "a" {"&ns" ["b" "c"] "class" "world"} "hello")))]
   [test-ns-attributes
    (fn [self]
      (test-tag "<b:c:a\s+class=\"world\"\s*/>"
                (xmlhy "a" {"&ns" ["b" "c"] "class" "world"})))]
   [test-nested-tags
    (fn [self]
      (test-tag "<b:c:a\s+class=\"world\"\s*><d:e:f\s*/></b:c:a>"
                (xmlhy "a" {"&ns" ["b" "c"] "class" "world"}
                        (xmlhy "f" {"&ns" ["d" "e"]}))))]
   [test-xml-declare-1
    (fn [self]
      (test-tag "<\?xml\s+version=\"1.0\"\s*\?>" (xmlhy-declare 1.0)))]
   [test-xml-declare-2
    (fn [self]
      (test-tag "<\?xml\s+version=\"1.0\"\s*encoding=\"ascii\"\s*\?>" (xmlhy-declare 1.0 "ascii")))]
   [test-xml-declare-3
    (fn [self]
      (test-tag "<\?xml\s+version=\"1.0\"\s*encoding=\"ascii\"\s*\?>" (xmlhy-declare 1.0 "ascii" None)))]
   [test-xml-declare-4
    (fn [self]
      (test-tag "<\?xml\s+version=\"1.0\"\s*encoding=\"ascii\"\s*standalone=\"yes\"\s*\?>" (xmlhy-declare 1.0 "ascii" True)))]
   [test-xml-declare-5
    (fn [self]
      (test-tag "<\?xml\s+version=\"1.0\"\s*standalone=\"no\"\s*\?>" (xmlhy-declare 1.0 None False)))]
   [test-sanitize
    (fn [self]
      (.assertEqual self
                    "&lt;&gt;&apos;&quot;&amp;"
                    (x.sanitize "<>'\"&")))]
   [test-comment-normal
    (fn [self]
      (test-tag "<!\-\-\s*hello\s*\-\->" (xmlhy-comment " hello ")))]
   [test-comment-empty
    (fn [self]
      (test-tag "<!\-\-\s*\-\->" (xmlhy-comment)))]
   [test-comment-newline
    (fn [self]
      (test-tag "<!\-\-\n\-\->" (xmlhy-comment (xmlhy-crlf))))]
   [test-comment-newlines
    (fn [self]
      (test-tag "<!\-\-\n\n\-\->" (xmlhy-comment (xmlhy-crlf 2))))]
   [test-comment-tab
    (fn [self]
      (test-tag "<!\-\-\t\-\->" (xmlhy-comment (xmlhy-tab))))]
   [test-comment-tabs
    (fn [self]
      (test-tag "<!\-\-\t\t\-\->" (xmlhy-comment (xmlhy-tab 2))))]
   [test-comment-space
    (fn [self]
      (test-tag "<!\-\- \-\->" (xmlhy-comment (xmlhy-space))))]
   [test-comment-spaces
    (fn [self]
      (test-tag "<!\-\-  \-\->" (xmlhy-comment (xmlhy-space 2))))]
   [test-xml-stylesheet-1
    (fn [self]
      (test-tag "<\?xml-stylesheet\s*\?>" (xmlhy-stylesheet)))]
   [test-xml-stylesheet-2
    (fn [self]
      (test-tag "<\?xml-stylesheet\s*href=\"style.xsl\"\s*type=\"text/xsl\"\s*\?>" (xmlhy-stylesheet "style.xsl" "text/xsl")))]
   [test-xml-stylesheet-3
    (fn [self]
      (test-tag "<\?xml-stylesheet\s*href=\"style.xsl\"\s*type=\"text/xsl\"\s*alternate=\"no\"\s*\?>"
                (xmlhy-stylesheet "style.xsl" "text/xsl" None None None False)))]
   [test-mixed-inputs-1         ;ignore contents after "hello", produces stderr output
    (fn [self]
      (test-tag "<a\s*>hello</a>" (xmlhy "a" {} "hello" (xmlhy-crlf))))]
   [test-mixed-inputs-2         ;ignore strings, produces stderr output
    (fn [self]
      (test-tag "<a\s*>\n</a>" (xmlhy "a" {} (xmlhy-crlf) "hello")))]
   [test-generated-string
    (fn [self]
      (test-tag "<a\s*>111</a>" (xmlhy "a" {} (xmlhy-print (* 3 "1")))))]
   [test-generated-string-bad
    (fn [self]
      (test-tag "<a\s*></a>" (xmlhy "a" {} (* 3 "1"))))]
   [test-generated-attribute-1
    (fn [self]
      (test-tag "<b:c:a\s+class=\"111\"\s*>hello</b:c:a>"
                (xmlhy "a" {"&ns" ["b" "c"] "class" (* 3 "1")} "hello")))]
   [test-generated-attribute-2
    (fn [self]
      (test-tag "<b:c:a\s+aaa=\"222\"\s*>hello</b:c:a>"
                (xmlhy "a" {"&ns" ["b" "c"] (* 3 "a") (* 3 "2")} "hello")))]
   [test-generated-name
    (fn [self]
      (test-tag "<b:c:zzz\s+aaa=\"222\"\s*>hello</b:c:zzz>"
                (xmlhy (* 3 "z") {"&ns" ["b" "c"] (* 3 "a") (* 3 "2")} "hello")))]])

(defmain [&rest args]
  (run_unittest Test))
