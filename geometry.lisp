;;;; geometry.lisp

(in-package :com.div0.geometry)

(defun clamp (value min-val max-val)
 "Return a value that cuts the value off at the min-val and the max-val."
 (if (every #'numberp (list value min-val max-val))
  (max min-val (min value max-val))
  (error "Not given all number inputs")))

(defun map-value (value in-min in-max out-min out-max)
  
  "Map the value that from the in range to the out range."

  ;;ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
  (+ out-min (* (- out-max out-min) (/ (- value in-min) (- in-max in-min)))))

(defun distance^2 (vec1 vec2)
  "Gives the distance squared between two vectors, taking the shortest vector as the length for both (I think)"
  ;; sum( (a-b)^2 for a and b in vec1 and vec2 ))
  (reduce #'+
    (map 'vector
         (lambda (a b) (expt (- a b) 2))
         vec1
     vec2)))

(defun distance (vec1 vec2)
  "Gives the distance between two vectors, taking the shortest vector as the length for both (I think)"
  (sqrt (distance^2 vec1 vec2)))

(defun vec+ (&rest vecs)
  "Sum up vectors"
  (apply #'map 'vector #'+ vecs))

(defun vec- (&rest vecs)
  "Subtract vectors"
  (apply #'map 'vector #'- vecs))

(defun vec* (&rest vecs)
  "Multiply vectors"
  (apply #'map 'vector #'* vecs))

(defun vec/ (&rest vecs)
  "Divide vectors"
  (apply #'map 'vector #'/ vecs))

(defun vec-scale (vec scalar)
  "Multiply a vector by a scalar."
  (map 'vector #'(lambda (x) (* x scalar)) vec))

(defun magnitude (vec)
  "Get the magnitude of a vector."
  (sqrt (reduce #'+
         (map 'vector
                (lambda (x) (* x x))
                vec))))

(defun dot-product (vec1 vec2)
  "Find the dot product of the two vectors, in the dimensions of the shortest one. Equation interpreted from https://www.mathsisfun.com/algebra/vectors-dot-product.html."
  (reduce #'+ (map 'vector #'* vec1 vec2)))

(defun in-bounds (index sequence)
  (let ((len (length sequence)))
    (and (< 0 index)
         (< index (1- len)))))

(defun elt-0 (seq index)
  "Like the function ELT, but return 0 if out of bounds."
  (if (in-bounds index seq)
    (elt seq index)
    0))

(defun x (vec)
  "Get the X component of a vector, defaulting to 0"
  (elt-0 vec 0))

(defun y (vec)
  "Get the Y component of a vector, defaulting to 0"
  (elt-0 vec 1))

(defun z (vec)
  "Get the Z component of a vector, defaulting to 0"
  (elt-0 vec 2))

(defun cross-product-3d (vec1 vec2)
  "Find the cross product (3D vector) of the two vectors in 3D space, the equation is taken from https://www.mathsisfun.com/algebra/vectors-cross-product.html"
  (vector (- (* (y vec1) (z vec2)) (* (z vec1) (y vec2)))
    (- (* (z vec1) (x vec2)) (* (x vec1) (z vec2)))
    (- (* (x vec1) (y vec2)) (* (y vec1) (x vec2)))))

(defun average (value1 &rest values)
  "Get the average number of the given values."
  (let ((values (append (list value1) values)))
    (/ (apply #'+ values) (length values))))

(defun midpoint (vec1 &rest vecs)
  "Return the average of the given points. Calling with one argument should return the same vector."
  (let ((vecs (append (list vec1) vecs)))
    (apply #'map 'vector #'average vecs)))

(defun dot-product-normalized (vec1 vec2)
      "Return the normalized dot product of two vectors."
      (let ((m (* (magnitude vec1) (magnitude vec2))))
        (/ (dot-product vec1 vec2) m)))
