;; an-integer-starting-from will try numbers inifinitely starting from
;; given argument. Because of that there will be no upper bound. Thus, we
;; will end up testing numbers (1 1 1) -> (1 1 2) -> (1 1 3) -> (1 1 4) -> and 
;; so on. First 2 numbers will never change, the only number that will be 
;; changing is the 3rd one.

(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))

(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))

(define (a-pythagorean-triple)
  (let ((k (an-integer-starting-from 1)))
    (let ((i (an-integer-between 1 (- k 1))))
      (let ((j (an-integer-between 1 (- k 1))))
        (require (= (+ (* i i) (* j j))
                    (* k k)))
        (list i j k)))))

(a-pythagorean-triple)
;; => (3 4 5)

try-again
;; => (4 3 5)

try-again
;; => (6 8 10)

