;; test double quoting
(import [xmlhy.xmlhy :as x]
        [sys]
        [unittest [TestCase]]
        [test.support [run_unittest]]
        [re])

(require xmlhy.xmlhy)

(defmacro test-tag [regex xmlhy-func]
  `(let [[xmlhy-buffer (x.WritableObject)]]
     (import [xmlhy.util :as xh])
     ~xmlhy-func
     (.assertTrue self
                  (.fullmatch (re.compile ~regex) (.concat xmlhy-buffer))
                  (+ "Got: " (.concat xmlhy-buffer)))))
(defclass Test [TestCase]
  [])

(defmain [&rest args]
  (run_unittest Test))
