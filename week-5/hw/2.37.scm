;; need to redefine accumulate here cause in Berkley lib for scheme
;; they have their own impl of accumulate procedure which accepts 
;; only 2 params (instead of 3 in the origin)
(define (accumulate op initial seq)
  (if (null? seq)
    initial
    (op (car seq) (accumulate op initial (cdr seq)))))

;; procedure from 2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    '()
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;; ANSWER
(define (matrix-*-vector m v)
  (map (lambda (w) (dot-product w v)) m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v) (matrix-*-vector cols v)) m)))

;; tests
(define test-matrix (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(matrix-*-vector test-matrix (car test-matrix))
(transpose test-matrix)
(matrix-*-matrix test-matrix test-matrix)
