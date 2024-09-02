;; option 1
(define (vector-append vec1 vec2)
  (define (vector-copy vec-from from-idx vec-to to-idx)
    (if (> from-idx (- (vector-length vec-from) 1))
      vec-to
      (begin (vector-set! vec-to to-idx (vector-ref vec-from from-idx))
             (vector-copy vec-from (+ from-idx 1) vec-to (+ to-idx 1)))))
  (let ((result (make-vector (+ (vector-length vec1) (vector-length vec2)))))
    (vector-copy vec1 0 result 0)
    (vector-copy vec2 0 result (vector-length vec1))))

;; option 2
(define (vector-append vec1 vec2)
  (define (loop result result-idx vec1-idx vec2-idx)
    (cond
      ((> vec2-idx -1)
       (vector-set! result result-idx (vector-ref vec2 vec2-idx))
       (loop result (- result-idx 1) vec1-idx (- vec2-idx 1)))
      ((> vec1-idx -1)
       (vector-set! result result-idx (vector-ref vec1 vec1-idx))
       (loop result (- result-idx 1) (- vec1-idx 1) vec2-idx))
      (else result)))
  (let ((vec1-len (vector-length vec1)) (vec2-len (vector-length vec2)))
    (loop (make-vector (+ vec1-len vec2-len))
      (- (+ vec1-len vec2-len) 1)
      (- vec1-len 1)
      (- vec2-len 1))))

(define vec1 (vector 1 2 3))
(define vec2 (vector 4 5 6 7 8 9 10))

(vector-append vec1 vec2)
