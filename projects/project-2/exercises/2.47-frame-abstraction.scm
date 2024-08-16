;; using list
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame f)
  (list-ref f 0))

(define (edge1-frame f)
  (list-ref f 1))

(define (edge2-frame f)
  (list-ref f 2))

(define test-frame (make-frame 1 2 3))

;; tests
(= 1 (origin-frame test-frame))
(= 2 (edge1-frame test-frame))
(= 3 (edge2-frame test-frame))

;; using cons
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame f)
  (car f))

(define (edge1-frame f)
  (cadr f))

(define (edge2-frame f)
  (cddr f))

(define test-frame (make-frame 1 2 3))

;; tests
(= 1 (origin-frame test-frame))
(= 2 (edge1-frame test-frame))
(= 3 (edge2-frame test-frame))
