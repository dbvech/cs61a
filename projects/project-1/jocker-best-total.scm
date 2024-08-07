(define (best-total hand)
  (define (filter-special-cards hand)
    (cond
      ((empty? hand) '())
      ((or
        (eq? (bl (first hand)) 'a)
        ;; add jocker here
        (eq? (first hand) 'jocker))
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
                               21))
        ; new cond clause for jocker card
        ((eq? (first hand) 'jocker)
         (get-closer-from-sent (se (iter (+ points 1) (bf hand))
                                   (iter (+ points 2) (bf hand))
                                   (iter (+ points 3) (bf hand))
                                   (iter (+ points 4) (bf hand))
                                   (iter (+ points 5) (bf hand))
                                   (iter (+ points 6) (bf hand))
                                   (iter (+ points 7) (bf hand))
                                   (iter (+ points 8) (bf hand))
                                   (iter (+ points 9) (bf hand))
                                   (iter (+ points 10) (bf hand))
                                   (iter (+ points 11) (bf hand)))
                               21)))))

  (iter (calc-fixed-worth-cards hand) (filter-special-cards hand)))
