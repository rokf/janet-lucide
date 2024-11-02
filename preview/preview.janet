(import spork/htmlgen)

(import lucide)

(defn- layout [rows]
  (htmlgen/html
    [:html {:lang "en"}
     [:head
      [:meta {:charset "utf-8"}]
      [:meta {:name "viewport" :content "width=device-width, initial-scale=1"}]
      [:meta {:name "color-scheme" :content "light dark"}]
      [:link {:rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css"}]
      [:title "Lucide Icon Preview"]]
     [:body {:class "container"}
      [:header
       [:hgroup [:h2 "Lucide Icon Preview"] [:p "These are the icons you'll get by importing the module."]]]
      [:main
       [:table {:class "striped"} [:thead [:tr
                                           [:th {:scope "col"} "Source"]
                                           [:th {:scope "col"} "Icon"]
                                           [:th {:scope "col"} "Function"]
                                           [:th {:scope "col"} "Actions"]]] [:tbody ;rows]]]]]))

(def rows @[])

(def lucide-module (require "lucide"))
(def ordered-keys (sort (keys lucide-module)))

(each k ordered-keys (array/push rows [:tr
                                       [:td [:code (string k ".svg")]]
                                       [:td ((get-in lucide-module [k :value]))]
                                       [:td [:code (string "(lucide/" k ")")]]
                                       [:td [:button {:class "contrast"
                                                      :data-tooltip "Copy function call to clipboard"
                                                      :data-placement "left"
                                                      :onclick (string/format "navigator.clipboard.writeText(\"%s\")" (string "(lucide/" k ")"))} (lucide/clipboard-copy 16)]]]))

(spit "preview/preview.html" (layout rows))
