;; What is the type of the value of (delay (+ 1 27))? What is the type of the value of (force (delay
;; (+ 1 27)))?

(delay (+ 1 27))
;; => promise/closure

(force (delay (+ 1 27)))
;; => 28
