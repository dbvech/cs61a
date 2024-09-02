(define (vector-filter pred vec)
  (define (vector-prepend vec val)
    (define (loop newvec n)
      (if (= n 0)
        (begin
         (vector-set! newvec n val)
         newvec)
        (begin
         (vector-set! newvec n (vector-ref vec (- n 1)))
         (loop newvec (- n 1)))))
    (loop (make-vector (+ (vector-length vec) 1)) (vector-length vec)))
  (define (loop newvec n)
    (cond
      ((< n 0) newvec)
      ((pred (vector-ref vec n)) (loop (vector-prepend newvec (vector-ref vec n)) (- n 1)))
      (else (loop newvec (- n 1)))))
  (loop (make-vector 0) (- (vector-length vec) 1)))
