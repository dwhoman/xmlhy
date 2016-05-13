(import [xmlhy-util] [xmlhy])

(require xmlhy)
;; (defmacro xmlhy-tag [tag-ns-name]
;;   (with-gensyms [name]
;;     `(defmacro ~tag-ns-name [&rest body]
;;        (defun ~tag-ns-name [])
;;        (let [[~name (last (.split (. ~tag-ns-name --name--) "_" 1))]]
;;          `(xmlhy ~~name ~@(list body))))))
(defreader ^ [tag-ns-name] `(xmlhy-tag ~tag-ns-name))

(xmlhy-tag xhtml-a)
;#^xhtml-a
#^xhtml-abbr
#^xhtml-address
#^xhtml-area
#^xhtml-article
#^xhtml-aside
#^xhtml-audio
#^xhtml-b
#^xhtml-base
#^xhtml-bdi
#^xhtml-bdo
#^xhtml-blockquote
#^xhtml-body
#^xhtml-br
#^xhtml-button
#^xhtml-canvas
#^xhtml-caption
#^xhtml-cite
#^xhtml-code
#^xhtml-col
#^xhtml-colgroup
#^xhtml-data
#^xhtml-datalist
#^xhtml-dd
#^xhtml-del
#^xhtml-dfn
#^xhtml-div
#^xhtml-dl
#^xhtml-dt
#^xhtml-em
#^xhtml-embed
#^xhtml-fieldset
#^xhtml-figcaption
#^xhtml-figure
#^xhtml-footer
#^xhtml-form
#^xhtml-h1
#^xhtml-h2
#^xhtml-h3
#^xhtml-h4
#^xhtml-h5
#^xhtml-h6
#^xhtml-head
#^xhtml-header
#^xhtml-hgroup
#^xhtml-hr
#^xhtml-html
#^xhtml-i
#^xhtml-iframe
#^xhtml-img
#^xhtml-input
#^xhtml-ins
#^xhtml-kbd
#^xhtml-keygen
#^xhtml-label
#^xhtml-legend
#^xhtml-li
#^xhtml-link
#^xhtml-main
#^xhtml-map
#^xhtml-mark
#^xhtml-meta
#^xhtml-meter
#^xhtml-nav
#^xhtml-noscript
#^xhtml-object
#^xhtml-ol
#^xhtml-optgroup
#^xhtml-option
#^xhtml-output
#^xhtml-p
#^xhtml-param
#^xhtml-pre
#^xhtml-progress
#^xhtml-q
#^xhtml-rb
#^xhtml-rp
#^xhtml-rt
#^xhtml-rtc
#^xhtml-ruby
#^xhtml-s
#^xhtml-samp
#^xhtml-script
#^xhtml-section
#^xhtml-select
#^xhtml-small
#^xhtml-source
#^xhtml-span
#^xhtml-strong
#^xhtml-style
#^xhtml-sub
#^xhtml-sup
#^xhtml-table
#^xhtml-tbody
#^xhtml-td
#^xhtml-template
#^xhtml-textarea
#^xhtml-tfoot
#^xhtml-th
#^xhtml-thead
#^xhtml-time
#^xhtml-title
#^xhtml-tr
#^xhtml-track
#^xhtml-u
#^xhtml-ul
#^xhtml-var
#^xhtml-video
#^xhtml-wbr

(defmain [&rest args]
  (def xmlhy-buffer sys.--stdout--)
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
  (xmlhy-crlf))
