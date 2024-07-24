;; Do exercise 1.6, page 25. This is an essay question; you needn’t hand in any computer
;; printout, unless you think the grader can’t read your handwriting. If you had trouble
;; understanding the square root program in the book, explain instead what will happen if
;; you use new-if instead of if in the pigl Pig Latin procedure.

;; Alyssa P. Hacker doesn’t see why if needs to be provided as a special form.
;; “Why can’t I just define it as an ordinary procedure in terms of cond?” she asks.
;; Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of if:
(define (new-if predicate
                then-clause
                else-clause)
  (cond (predicate then-clause)
    (else else-clause)))

;; Eva demonstrates the program for Alyssa:
(new-if (= 2 3) 0 5)
5

(new-if (= 1 1) 0 5)
0
;; Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

;; What happens when Alyssa attempts to use this to compute square roots? Explain.

;; ANSWER: 
;; Scheme uses applicative-order evaluation, so all procedure arguments should be
;; evaluated before "passing" to procedure, thus:
;; when "sqrt-iter" procedure will be evaluating, it will first try to evaluate all 
;; arguments for "new-if" procedure. Because to evaluate one of the argument (3rd) we need to 
;; invoke `sqrt-iter` procedure itself (recursion), it will fall into infinite cycle.
;; On the other hand, `if` is a special form, so it will evaluate only one of the arguments
