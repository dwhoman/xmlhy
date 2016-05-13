(import [xmlhy-util] [xmlhy])
(require xmlhy)

;;; can't get hy to import xmlhy-tag from xmlhy.hy when this script
;;; is used in another script, works here without xmlhy-tag being
;;; locally defined

(defmacro xmlhy-tag [tag-ns-name]
  (with-gensyms [name]
    `(defmacro ~tag-ns-name [&rest body]
       (defun ~tag-ns-name [])
       (let [[~name (last (.split (. ~tag-ns-name --name--) "_" 1))]]
         `(xmlhy ~~name ~@(list body))))))
(defreader ^ [tag-ns-name] `(xmlhy-tag ~tag-ns-name))
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
