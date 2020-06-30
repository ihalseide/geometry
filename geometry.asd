;;;; geometry.asd

(asdf:defsystem #:com.div0.geometry
  :description "Functions and operations related to geometry."
  :author "Izak Halseide"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "geometry" :depends-on ("package"))))
