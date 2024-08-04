(load "1.37.scm")



(+ 2
   (cont-frac-iter (lambda (i) 1.0)
                   (lambda (i)
                           (if (= (remainder (+ i 1) 3) 0)
                             (* 2 (/ (+ i 1) 3))
                             1))
                   10))
