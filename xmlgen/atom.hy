(import [xmlgen-helpers] [xmlgen])
(require xmlgen)

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
#^atom-author
#^atom-category
#^atom-content
#^atom-contributor
#^atom-div
#^atom-email
#^atom-entry
#^atom-feed
#^atom-generator
#^atom-icon
#^atom-id
#^atom-link
#^atom-logo
#^atom-name
#^atom-published
#^atom-rights
#^atom-source
#^atom-subtitle
#^atom-summary
#^atom-title
#^atom-updated
#^atom-uri
#^atom-p
