(import spork/htmlgen)

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
                                           [:th {:scope "col"} "Function"]]] [:tbody ;rows]]]]]))

(def rows @[])

(eachp [k v] (require "lucide") (array/push rows [:tr
                                                  [:td (string k ".svg")]
                                                  [:td ((get v :value))]
                                                  [:td (string "(lucide/" k ")")]]))

(spit "preview/preview.html" (layout rows))
