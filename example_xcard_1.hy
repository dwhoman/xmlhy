(import [xmlhy.xmlhy :as x]
        [xmlhy.xmlhy-util]
        [xmlhy.xcard]
        [sys])

(require xmlhy.xmlhy)
(require xmlhy.xcard)
(def xmlhy-buffer sys.--stdout--)
(xmlhy-declare 1.0 "UTF-8")
(xcard-vcards
 {"&ns" "x" "xmlns:x" "urn:ietf:params:xml:ns:vcard-4.0"}
 (xcard-vcard {"&ns" "x"}
  (xcard-fn {"&ns" "x"}
   (xcard-text {"&ns" "x"} "Simon Perreault"))
  (xcard-n {"&ns" "x"}
   (xcard-surname {"&ns" "x"} "Perreault")
   (xcard-given {"&ns" "x"} "Simon")
   (xcard-additional)
   (xcard-prefix)
   (xcard-suffix "ing. jr")
   (xcard-suffix "M.Sc."))
  (xcard-bday
   (xcard-date "--0203"))
  (xcard-anniversary
   (xcard-date-time "20090808T1430-0500"))
  (xcard-gender
   (xcard-sex "M"))
  (xcard-lang
   (xcard-parameters
    (xcard-pref
     (xcard-integer "1")))
   (xcard-language-tag "fr"))
  (xcard-lang
   (xcard-parameters
    (xcard-pref
     (xcard-integer "2")))
   (xcard-language-tag "en"))
  (xcard-org
   (xcard-parameters
    (xcard-type
     (xcard-text "work")))
   (xcard-text "Viagenie"))
  (xcard-adr
   (xcard-parameters
    (xcard-type
     (xcard-text "work"))
    (xcard-label
     (xcard-text "Simon Perreault
2875 boul. Laurier, suite D2-630
Quebec, QC, Canada
G1V 2M2")))
   (xcard-pobox)
   (xcard-ext)
   (xcard-street "2875 boul. Laurier, suite D2-630")
   (xcard-locality "Quebec")
   (xcard-region "QC")
   (xcard-code "G1V 2M2")
   (xcard-country "Canada"))
  (xcard-tel
   (xcard-parameters
    (xcard-type
     (xcard-text "work")
     (xcard-text "voice")))
   (xcard-uri "tel:+1-418-656-9254;ext=102"))
  (xcard-tel
   (xcard-parameters
    (xcard-type
     (xcard-text "work")
     (xcard-text "text")
     (xcard-text "voice")
     (xcard-text "cell")
     (xcard-text "video")))
   (xcard-uri "tel:+1-418-262-6501"))
  (xcard-email
   (xcard-parameters
    (xcard-type
     (xcard-text "work")))
   (xcard-text "simon.perreault@viagenie.ca"))
  (xcard-geo
   (xcard-parameters
    (xcard-type
     (xcard-text "work")))
   (xcard-uri "geo:46.766336,-71.28955"))
  (xcard-key
   (xcard-parameters
    (xcard-type
     (xcard-text "work")))
   (xcard-uri "http://www.viagenie.ca/simon.perreault/simon.asc"))
  (xcard-tz
   (xcard-text "America/Montreal"))
  (xcard-url
   (xcard-parameters
    (xcard-type
     (xcard-text "home")))
   (xcard-uri "http://nomis80.org"))))

;;; example from RFC 6351 with namespace added to the first few elements

;;  <?xml version="1.0" encoding="UTF-8"?>
;;    <vcards xmlns="urn:ietf:params:xml:ns:vcard-4.0">
;;      <vcard>
;;        <fn><text>Simon Perreault</text></fn>
;;        <n>
;;          <surname>Perreault</surname>
;;          <given>Simon</given>
;;          <additional/>
;;          <prefix/>
;;          <suffix>ing. jr</suffix>
;;          <suffix>M.Sc.</suffix>
;;        </n>
;;        <bday><date>--0203</date></bday>
;;        <anniversary>
;;          <date-time>20090808T1430-0500</date-time>
;;        </anniversary>
;;        <gender><sex>M</sex></gender>
;;        <lang>
;;          <parameters><pref><integer>1</integer></pref></parameters>
;;          <language-tag>fr</language-tag>
;;        </lang>
;;        <lang>
;;          <parameters><pref><integer>2</integer></pref></parameters>
;;          <language-tag>en</language-tag>
;;        </lang>
;;        <org>
;;          <parameters><type><text>work</text></type></parameters>
;;          <text>Viagenie</text>
;;        </org>
;;        <adr>
;;          <parameters>
;;            <type><text>work</text></type>
;;            <label><text>Simon Perreault
;;    2875 boul. Laurier, suite D2-630
;;    Quebec, QC, Canada
;;    G1V 2M2</text></label>
;;          </parameters>
;;          <pobox/>
;;          <ext/>
;;          <street>2875 boul. Laurier, suite D2-630</street>
;;          <locality>Quebec</locality>
;;          <region>QC</region>
;;          <code>G1V 2M2</code>
;;          <country>Canada</country>
;;        </adr>
;;        <tel>
;;          <parameters>
;;            <type>
;;              <text>work</text>
;;              <text>voice</text>
;;            </type>
;;          </parameters>
;;          <uri>tel:+1-418-656-9254;ext=102</uri>
;;        </tel>
;;        <tel>
;;          <parameters>
;;            <type>
;;              <text>work</text>
;;              <text>text</text>
;;              <text>voice</text>
;;              <text>cell</text>
;;              <text>video</text>
;;            </type>
;;          </parameters>
;;          <uri>tel:+1-418-262-6501</uri>
;;        </tel>
;;        <email>
;;          <parameters><type><text>work</text></type></parameters>
;;          <text>simon.perreault@viagenie.ca</text>
;;        </email>
;;        <geo>
;;          <parameters><type><text>work</text></type></parameters>
;;          <uri>geo:46.766336,-71.28955</uri>
;;        </geo>
;;        <key>
;;          <parameters><type><text>work</text></type></parameters>
;;          <uri>http://www.viagenie.ca/simon.perreault/simon.asc</uri>
;;        </key>
;;        <tz><text>America/Montreal</text></tz>
;;        <url>
;;          <parameters><type><text>home</text></type></parameters>
;;          <uri>http://nomis80.org</uri>
;;        </url>
;;      </vcard>
;;    </vcards>
