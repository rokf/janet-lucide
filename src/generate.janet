# This script takes SVG files from the lucide/icons subfolder and
# produces Janet functions in the src/lucide.jimage file - a function
# per icon.

(def- filenames (filter (fn [name]
                          (string/has-suffix? ".svg" name)) (os/dir "lucide/icons")))

(defn- element-to-tuple [tag attrs &opt children]
  (default children [])
  [tag (table ;attrs) ;children])

# The HTML PEG from https://janet.guide/pegular-expressions/ was taken as a
# base for this one.
(def- svg-peg (peg/compile ~{:main (* :nodes -1)
                             :nodes (any (+ :element :trash))
                             :element (unref
                                        {:main (/ (+ :self-closing-tag (* :open-tag (group :nodes) :close-tag)) ,element-to-tuple)
                                         :self-closing-tag (* "<" (/ (<- :w+) ,keyword) (group (? (* :s+ :attributes))) "/>")
                                         :open-tag (* "<" (/ (<- :w+ :tag-name) ,keyword) (group (? (* :s+ :attributes))) ">")
                                         :attributes
                                         {:main (some (* :attribute (? :s+)))
                                          :attribute (* (/ (<- (some (+ :w "-"))) ,keyword) "=" :quoted-string)
                                          :quoted-string (* `"` (<- (any (if-not `"` 1))) `"`)}
                                         :close-tag (* "</" (backmatch :tag-name) ">")})
                             :trash (any (if-not "<" 1))}))

(def out-env (make-env))

(each filename filenames (do
                           (def content (slurp (string "lucide/icons/" filename)))
                           (def just-filename (first (string/split "." filename)))
                           (def svg (first (peg/match svg-peg content)))
                           (put out-env (symbol just-filename) @{:value (fn [&opt size]
                                                                          (default size 24)
                                                                          (def svg-copy (array ;svg))
                                                                          (put-in svg-copy [1 :height] (string size))
                                                                          (put-in svg-copy [1 :width] (string size))
                                                                          (tuple ;svg-copy))})))

(with [f (file/open "src/lucide.jimage" :w)]
  (file/write f (make-image out-env)))
