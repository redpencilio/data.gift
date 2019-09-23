(in-package :mu-cl-resources)

;;;;
;; NOTE
;; docker-compose stop; docker-compose rm; docker-compose up
;; after altering this file.

;; Describe your resources here

;; The general structure could be described like this:
;;
;; (define-resource <name-used-in-this-file> ()
;;   :class <class-of-resource-in-triplestore>
;;   :properties `((<json-property-name-one> <type-one> ,<triplestore-relation-one>)
;;                 (<json-property-name-two> <type-two> ,<triplestore-relation-two>>))
;;   :has-many `((<name-of-an-object> :via ,<triplestore-relation-to-objects>
;;                                    :as "<json-relation-property>")
;;               (<name-of-an-object> :via ,<triplestore-relation-from-objects>
;;                                    :inverse t ; follow relation in other direction
;;                                    :as "<json-relation-property>"))
;;   :has-one `((<name-of-an-object :via ,<triplestore-relation-to-object>
;;                                  :as "<json-relation-property>")
;;              (<name-of-an-object :via ,<triplestore-relation-from-object>
;;                                  :as "<json-relation-property>"))
;;   :resource-base (s-url "<string-to-which-uuid-will-be-appended-for-uri-of-new-items-in-triplestore>")
;;   :on-path "<url-path-on-which-this-resource-is-available>")

(define-resource concept ()
  :class (s-prefix "skos:Concept")
  :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
  :features '(include-uri)
  :has-many `((concept-scheme :via ,(s-prefix "skos:inScheme")
                              :as "concept-schemes")
              (concept-scheme :via ,(s-prefix "skos:topConceptOf")
                             :as "top-concept-of")
              (concept :via ,(s-prefix "skos:broader")
                       :as "broader-concepts")
              (concept :via ,(s-prefix "skos:broader")
                       :inverse t
                       :as "narrower-concepts")
              (concept :via ,(s-prefix "skos:broadMatch")
                       :as "broad-matches")
              (concept :via ,(s-prefix "skos:broadMatch")
                       :inverse t
                       :as "narrower-matches"))
  :resource-base (s-url "http://data.gift/concepts/")
  :on-path "concepts")

(define-resource concept-scheme ()
  :class (s-prefix "skos:ConceptScheme")
  :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
  :features '(include-uri)
  :has-many `((concept :via ,(s-prefix "skos:inScheme")
                       :inverse t
                       :as "concepts")
              (concept :via ,(s-prefix "skos:topConceptOf")
                       :inverse t
                       :as "top-concepts"))
  :resource-base (s-url "http://data.gift/concept-schemes/")
  :on-path "conceptschemes")
