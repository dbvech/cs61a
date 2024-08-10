(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items (list)))


;; because the following lines constructs a pair with current squared 
;; number "at left" (`car` position) and rest of the answers "to right" (`cdr`)
;; (cons (square (car things))
;;        answer))))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square
                   (car things))))))
  (iter items '()))

;; this one doesn't work cause it takes the list of previous answers and put it
;; "as it is" to the `car` position of the box (`cons answer`), so in result 
;; there will be list with nested lists
(square-list (list 1 2 3 4))
