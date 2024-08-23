(load "../../cs61a/lib/obj")

(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)))
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)))

(define ordered-deck (make-ordered-deck))

(define (shuffle deck)
  (if (null? deck)
    '()
    (let ((card (nth (random (length deck)) deck)))
      (cons card (shuffle (remove (lambda (c) (eq? c card)) deck))))))

(shuffle ordered-deck)

(define-class (deck)
  (instance-vars (deck-list (shuffle ordered-deck)))
  (method (deal)
          (if (null? deck-list)
            '()
            (let ((card (car deck-list)))
              (set! deck-list (cdr deck-list))
              card)))
  (method (empty?)
          (null? deck-list)))

(define my-deck (instantiate deck))
