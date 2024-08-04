(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
    ((= kinds-of-coins 2) 5)
    ((= kinds-of-coins 3) 10)
    ((= kinds-of-coins 4) 25)
    ((= kinds-of-coins 5) 50)))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
    ((or (< amount 0)
         (= kinds-of-coins 0))
     0)
    (else
     (+ (cc amount (- kinds-of-coins 1))
        (cc (- amount (first-denomination
                       kinds-of-coins))
            kinds-of-coins)))))

(define (cc-wrong-order amount kinds-of-coins)
  (cond
    ((or (< amount 0)
         (= kinds-of-coins 0))
     0)
    ((= amount 0) 1)
    (else
     (+ (cc-wrong-order amount (- kinds-of-coins 1))
        (cc-wrong-order (- amount (first-denomination
                                   kinds-of-coins))
                        kinds-of-coins)))))

(cc 0 0) ; would result to 1
(cc-wrong-order 0 0) ; would result to 0
