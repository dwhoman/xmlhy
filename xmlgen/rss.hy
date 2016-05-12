(import [xmlgen-helpers] [xmlgen])
(require xmlgen)

;;; RSS 2.0 elements

;;; can't get hy to import xmlgen-tag from xmlgen.hy when this script
;;; is used in another script, works here without xmlgen-tag being
;;; locally defined

(defmacro xmlgen-tag [tag-ns-name]
  (with-gensyms [name]
    `(defmacro ~tag-ns-name [&rest body]
       (defun ~tag-ns-name [])
       (let [[~name (last (.split (. ~tag-ns-name --name--) "_" 1))]]
         `(xmlgen ~~name ~@(list body))))))
(defreader ^ [tag-ns-name] `(xmlgen-tag ~tag-ns-name))
#^rss-category
#^rss-channel
#^rss-cloud
#^rss-comments
#^rss-copyright
#^rss-description
#^rss-docs
#^rss-enclosure
#^rss-generator
#^rss-guid
#^rss-image
#^rss-item
#^rss-language
#^rss-lastBuildDate
#^rss-link
#^rss-managingEditor
#^rss-pubDate
#^rss-rating
#^rss-rss
#^rss-skipDays
#^rss-skipHours
#^rss-source
#^rss-textInput
#^rss-title
#^rss-ttl
#^rss-webMaster

(defmain [&rest args]
  (import [sys])
  (def xmlgen-buffer sys.--stdout--)
  (rss-rss))
