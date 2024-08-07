(define (best-total hand)
  (define (filter-special-cards hand)
    (cond
      ((empty? hand) '())
      ((eq? (bl (first hand)) 'a)
       (se (first hand) (filter-special-cards (bf hand))))
      (else (filter-special-cards (bf hand)))))

  (define (calc-fixed-worth-cards hand)
    (define (iter points hand)
      (if (empty? hand)
        points
        (let ((card (bl (first hand))))
          (cond
            ((number? card) (iter (+ points card) (bf hand)))
            ((member card '(j q k)) (iter (+ points 10) (bf hand)))
            (else (iter points (bf hand)))))))
    (iter 0 hand))

  (define (get-closer a b target)
    (cond
      ((or (= a target) (= b target)) target)
      ((and (< a target) (< b target)) (max a b))
      (else (min a b))))

  (define (get-closer-from-sent sent target)
    (if (= (length sent) 1)
      (first sent)
      (get-closer-from-sent
       (se (get-closer (first sent) (first (bf sent)) target)
           (bf (bf sent)))
       target)))

  (define (iter points hand)
    (if (empty? hand)
      points
      (cond
        ((eq? (bl (first hand)) 'a)
         (get-closer-from-sent (se (iter (+ points 1) (bf hand))
                                   (iter (+ points 11) (bf hand)))
                               21)))))

  (iter (calc-fixed-worth-cards hand) (filter-special-cards hand)))
