;; 1. if we call exp with two complex numbers as arguments:
;;    apply-generic will try to find coersion procedure for complex->complex
;;    it will find and use this procedure:
;;    (cond (t1->t2
;;      (apply-generic 
;;       op (t1->t2 a1) a2))
;;    but (t1->t2 a1) will return a1, so apply-generic will be invoked AGAIN with same args,
;;    so it will be endless recursion

;; 2. the apply-generic procedure behaves correctly, cause if there is no OP for numbers of
;;    same type (eg (complex complex)) then it throws an error indicating that OP is missing

;; 3.
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (if (= (length args) 2)
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            (if (eq? type1 type2) ;; HERE IS THE CHANGE
              (error "No method for the type" (list op type1))
              (let ((t1->t2
                     (get-coercion type1
                                   type2))
                    (t2->t1
                     (get-coercion type2
                                   type1)))
                (cond (t1->t2
                       (apply-generic
                        op (t1->t2 a1) a2))
                  (t2->t1
                   (apply-generic
                    op a1 (t2->t1 a2)))
                  (else
                   (error
                    "No method for 
                           these types"
                    (list
                     op
                     type-tags)))))))
          (error
           "No method for these types"
           (list op type-tags)))))))
