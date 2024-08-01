;; (define (fact n)
;;   (if (= n 0)
;; 1
;; (* n (fact (- n 1)))))
;; (fact 5)

((lambda (fact)
         (fact fact 5))
 (lambda (fact n)
         (if (= n 0)
           1
           (* n (fact fact (- n 1))))))
