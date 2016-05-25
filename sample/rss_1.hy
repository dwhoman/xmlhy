(import [xmlhy.util]
        [xmlhy.xmlhy :as x]
        [xmlhy.rss]
        [sys])
(require xmlhy.xmlhy xmlhy.rss)
;; produces http://www.rssboard.org/files/sample-rss-2.xml

(def xmlhy-buffer sys.--stdout--)
(xmlhy-declare 1.0)
(rss-rss
 {"version" "2.0" "a" "b" "&dq" True}
 (rss-channel
  (rss-title "Liftoff News")
  (rss-link "http://liftoff.msfc.nasa.gov/")
  (rss-description "Liftoff to Space Exploration.")


  (rss-language "en-us")
  (rss-pubDate "Tue, 10 Jun 2003 04:00:00 GMT")
  (rss-lastBuildDate "Tue, 10 Jun 2003 09:41:01 GMT")
  (rss-docs "http://blogs.law.harvard.edu/tech/rss")
  (rss-generator "Weblog Editor 2.0")
  (rss-managingEditor "editor@example.com")
  (rss-webMaster "webmaster@example.com")
  (rss-item
   (rss-title "Star City")
   (rss-link "http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp")
   (rss-description "How do Americans get ready to work with Russians aboard the International Space Station? They take a crash course in culture, language and protocol at Russia's &lt;a href='http://howe.iki.rssi.ru/GCTC/gctc_e.htm'&gt;Star City&lt;/a&gt;.")
   (rss-pubDate "Tue, 03 Jun 2003 09:39:21 GMT")
   (rss-guid "http://liftoff.msfc.nasa.gov/2003/06/03.html#item573"))
  (rss-item
   (rss-description "Sky watchers in Europe, Asia, and parts of Alaska and Canada will experience a &lt;a href='http://science.nasa.gov/headlines/y2003/30may_solareclipse.htm'&gt;partial eclipse of the Sun&lt;/a&gt; on Saturday, May 31st.")
   (rss-pubDate "Fri, 30 May 2003 11:06:42 GMT")
   (rss-guid "http://liftoff.msfc.nasa.gov/2003/05/30.html#item572"))
  (rss-item
   (rss-title "The Engine That Does More")
   (rss-link "http://liftoff.msfc.nasa.gov/news/2003/news-VASIMR.asp")
   (rss-description "Before man travels to Mars, NASA hopes to design new engines that will let us fly through the Solar System more quickly.  The proposed VASIMR engine would do that.")
   (rss-pubDate "Tue, 27 May 2003 08:37:32 GMT")
   (rss-guid "http://liftoff.msfc.nasa.gov/2003/05/27.html#item571"))
  (rss-item
   (rss-title "Astronauts' Dirty Laundry")
   (rss-link "http://liftoff.msfc.nasa.gov/news/2003/news-laundry.asp")
   (rss-description "Compared to earlier spacecraft, the International Space Station has many luxuries, but laundry facilities are not one of them.  Instead, astronauts have other options.")
   (rss-pubDate "Tue, 20 May 2003 08:56:02 GMT")
   (rss-guid "http://liftoff.msfc.nasa.gov/2003/05/20.html#item570"))))
