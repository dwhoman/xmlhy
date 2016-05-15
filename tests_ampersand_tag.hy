(import [xmlhy-util] [xmlhy])
(require xmlhy)
(defreader ^ [tag-ns-name] `(xmlhy-tag ~tag-ns-name))
#^amp-a&b
(defmain [&rest args]
  (def xmlhy-buffer (xmlhy.WritableObject))
  (amp-a&b)
  (let [[result (.concat xmlhy-buffer)]]
    (if (= "<a_b />" result)
      (print "Success")
      (print "Failure, got: %s" result))))
