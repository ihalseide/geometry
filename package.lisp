;;; package.lisp

(defpackage :com.div0.geometry
  (:nicknames :geometry
               :geom)
  (:documentation "A geometry library with vector and other functions.")
  (:use #:cl)
  (:export :distance^2 :distance
            :vec+ :vec- :vec* :vec/ :vec-scale
            :magnitude  :normalize
            :dot-product :dot-product-normalized :cross-product-3d
            :x :y :z
            :average :midpoint
            :clamp :map-value))