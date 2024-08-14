(define nil '())

(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append
       rest
       (map (lambda (x) (cons (car s) x)) rest)))))

(subsets (list 1 2 3))

;; For any set `s`, the subsets of `s` are the union of:
;; - subsets that do not include the first element: `rest`
;; - subsets that do include the first element: these are formed by taking each subset in rest and adding (car s) to the front.
