(import [xmlhy.xmlhy :as x]
        [xmlhy.xmlhy-util]
        [xmlhy.atom]
        [xmlhy.xhtml]
        [sys])
(require xmlhy.xmlhy xmlhy.atom xmlhy.xhtml)
;; produces example from https://tools.ietf.org/html/rfc4287

(def xmlhy-buffer sys.--stdout--)
(setv xmlhy.xmlhy-util.double-quote True)
(xmlhy-declare 1.0 "utf-8")
(atom-feed
 {"xmlns" "http://www.w3.org/2005/Atom"}
 (atom-title {"type" "text"} "dive into mark")
 (atom-subtitle
  {"type" "html"}
  "A &lt;em&gt;lot&lt;/em&gt; of effort
went into making this effortless")
 (atom-updated "2005-07-31T12:29:29Z")
 (atom-id "tag:example.org,2003:3\"/id")
 (atom-link {"rel" "alternate" "type" "text/html"
                   "hreflang" "en" "href" "http://example.org/"})
 (atom-link {"rel" "self" "type" "application/atom+xml"
                   "href" "http://example.org/feed.atom"})
 (atom-rights "Copyright (c) 2003, Mark Pilgrim")
 (atom-generator {"uri" "http://www.example.com/" "version" "1.0"}
                 "Example Toolkit")
 (atom-entry
  (atom-title "Atom draft-07 snapshot")
  (atom-link {"rel" "alternate" "type" "text/html"
                    "href" "http://example.org/2005/04/02/atom"})
  (atom-link {"rel" "enclosure" "type" "audio/mpeg" "length" "1337"
                    "href" "http://example.org/audio/ph34r_my_podcast.mp3"})
  (atom-id "tag:example.org,2003:3.2397")
  (atom-updated "2005-07-31T12:29:29Z")
  (atom-published "2003-12-13T08:29:29-04:00")
  (atom-author
   (atom-name "Mark Pilgrim")
   (atom-uri "http://example.org/")
   (atom-email"f8dy@example.com"))
  (atom-contributor
   (atom-name "Sam Ruby"))
  (atom-contributor
   (atom-name"Joe Gregorio"))
  (atom-content
   {"type" "xhtml" "xml:lang" "en" "xml:base" "http://diveintomark.org/"}
   (atom-div
    {"xmlns" "http://www.w3.org/1999/xhtml"}
    (xhtml-p
     (xhtml-i "[Update: The Atom draft is finished.]"))))))

;; <?xml version="1.0" encoding="utf-8"?>
;;    <feed xmlns="http://www.w3.org/2005/Atom">
;;      <title type="text">dive into mark</title>
;;      <subtitle type="html">
;;        A &lt;em&gt;lot&lt;/em&gt; of effort
;;        went into making this effortless
;;      </subtitle>
;;      <updated>2005-07-31T12:29:29Z</updated>
;;      <id>tag:example.org,2003:3</id>
;;      <link rel="alternate" type="text/html"
;;       hreflang="en" href="http://example.org/"/>
;;      <link rel="self" type="application/atom+xml"
;;       href="http://example.org/feed.atom"/>
;;      <rights>Copyright (c) 2003, Mark Pilgrim</rights>
;;      <generator uri="http://www.example.com/" version="1.0">
;;        Example Toolkit
;;      </generator>
;;      <entry>
;;        <title>Atom draft-07 snapshot</title>
;;        <link rel="alternate" type="text/html"
;;         href="http://example.org/2005/04/02/atom"/>
;;        <link rel="enclosure" type="audio/mpeg" length="1337"
;;         href="http://example.org/audio/ph34r_my_podcast.mp3"/>
;;        <id>tag:example.org,2003:3.2397</id>
;;        <updated>2005-07-31T12:29:29Z</updated>
;;        <published>2003-12-13T08:29:29-04:00</published>
;;        <author>
;;          <name>Mark Pilgrim</name>
;;          <uri>http://example.org/</uri>
;;          <email>f8dy@example.com</email>
;;        </author>
;;        <contributor>
;;          <name>Sam Ruby</name>
;;        </contributor>
;;        <contributor>
;;          <name>Joe Gregorio</name>
;;        </contributor>
;;        <content type="xhtml" xml:lang="en"
;;         xml:base="http://diveintomark.org/">
;;          <div xmlns="http://www.w3.org/1999/xhtml">
;;            <p><i>[Update: The Atom draft is finished.]</i></p>
;;          </div>
;;        </content>
;;      </entry>
;;    </feed>
