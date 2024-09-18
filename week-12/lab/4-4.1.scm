;; left to right
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((operand (eval (first-operand exps) env)))
      (cons operand
            (list-of-values (rest-operands exps) env)))))

;; right to left
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((rest (list-of-values (rest-operands exps) env)))
      (cons (eval (first-operand exps) env)
            rest))))

