(import [xmlhy.xmlhy :as x]
        [xmlhy.util]
        [xmlhy.svg]
        [sys])

;;; from https://www.w3.org/TR/SVG11/fonts.html
;; dashes should be preserved in tag names
(require xmlhy.xmlhy xmlhy.svg)
(def xmlhy-buffer sys.--stdout--)
(xmlhy-declare "1.0" None True)
(svg-svg
 {"width" "400px" "height" "300px" "version" "1.1" "xmlns" "http://www.w3.org/2000/svg"}
 (svg-defs
  (svg-font
   {"id" "Font1" "horiz-adv-x" "1000"}
   (svg-font-face
    {"font-family" "Super Sans"
                   "font-weight" "bold"
                   "font-style" "normal"
                   "units-per-em" "1000"
                   "cap-height" "600"
                   "x-height" "400"
                   "ascent" "700"
                   "descent" "300"
                   "alphabetic" "0"
                   "mathematical" "350"
                   "ideographic" "400"
                   "hanging" "500"}
    (svg-font-face-src
     (svg-font-face-name {"name" "Super Sans Bold"})))
   (svg-missing-glyph
    (svg-path {"d" "M 500 500 l 500 250 L 1500 500 L 1000 1500 z"}))
   (svg-glyph {"unicode" "ffl" "horiz-adv-x" "300" "d" "M 500 500 l 500 250 L 1500 500 L 1000 1500 z"})
   (svg-hkern {"g1" "V" "g2" "G" "k" "-40"})
   (svg-vkern {"g1" "V" "g2" "G" "k" "-40"})))
 (svg-text {"fill" "red" "x" "100" "y" "100" 
                   "style" "font-family: \"Super Sans\", Helvetica, sans-serif; font-weight: bold; font-style: normal"}
           "Text using embedded font. &#64260; ffl"))
