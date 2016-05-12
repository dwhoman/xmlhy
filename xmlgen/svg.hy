(import [xmlgen-helpers] [xmlgen])
(require xmlgen)

;;; SVG 1.1 elements

(defmacro xmlgen-tag [tag-ns-name]
  (with-gensyms [name]
    `(defmacro ~tag-ns-name [&rest body]
       (defun ~tag-ns-name [])
       (let [[~name (last (.split (. ~tag-ns-name --name--) "_" 1))]]
         `(xmlgen ~~name ~@(list body))))))
(defreader ^ [tag-ns-name] `(xmlgen-tag ~tag-ns-name))
#^svg-a
#^svg-altGlyph
#^svg-altGlyphDef
#^svg-altGlyphItem
#^svg-animate
#^svg-animateColor
#^svg-animateMotion
#^svg-animateTransform
#^svg-circle
#^svg-clipPath
#^svg-color-profile
#^svg-cursor
#^svg-defs
#^svg-desc
#^svg-ellipse
#^svg-feBlend
#^svg-feColorMatrix
#^svg-feComponentTransfer
#^svg-feComposite
#^svg-feConvolveMatrix
#^svg-feDiffuseLighting
#^svg-feDisplacementMap
#^svg-feDistantLight
#^svg-feFlood
#^svg-feFuncA
#^svg-feFuncB
#^svg-feFuncG
#^svg-feFuncR
#^svg-feGaussianBlur
#^svg-feImage
#^svg-feMerge
#^svg-feMergeNode
#^svg-feMorphology
#^svg-feOffset
#^svg-fePointLight
#^svg-feSpecularLighting
#^svg-feSpotLight
#^svg-feTile
#^svg-feTurbulence
#^svg-filter
#^svg-font
#^svg-font-face
#^svg-font-face-format
#^svg-font-face-name
#^svg-font-face-src
#^svg-font-face-uri
#^svg-foreignObject
#^svg-g
#^svg-glyph
#^svg-glyphRef
#^svg-hkern
#^svg-image
#^svg-line
#^svg-linearGradient
#^svg-marker
#^svg-mask
#^svg-metadata
#^svg-missing-glyph
#^svg-mpath
#^svg-path
#^svg-pattern
#^svg-polygon
#^svg-polyline
#^svg-radialGradient
#^svg-rect
#^svg-script
#^svg-set
#^svg-stop
#^svg-style
#^svg-svg
#^svg-switch
#^svg-symbol
#^svg-text
#^svg-textPath
#^svg-title
#^svg-tref
#^svg-tspan
#^svg-use
#^svg-view
#^svg-vkern
