;; Most versions of Lisp provide "and" and "or" procedures like the ones on page 19. In
;; principle there is no reason why these can’t be ordinary procedures, but some versions of
;; Lisp make them special forms. Suppose, for example, we evaluate
;; (or (= x 0) (= y 0) (= z 0))
;;
;; If or is an ordinary procedure, all three argument expressions will be evaluated before "or"
;; is invoked. But if the variable x has the value 0, we know that the entire expression has
;; to be true regardless of the values of y and z. A Lisp interpreter in which or is a special
;; form can evaluate the arguments one by one until either a true one is found or it runs out
;; of arguments.
;;
;; Your mission is to devise a test that will tell you whether Scheme’s "and" and "or" are special
;; forms or ordinary functions. This is a somewhat tricky problem, but it’ll get you thinking
;; about the evaluation process more deeply than you otherwise might.
;;
;; Why might it be advantageous for an interpreter to treat "or" as a special form and evaluate
;; its arguments one at a time? Can you think of reasons why it might be advantageous to
;; treat "or" as an ordinary function?


;; SOLUTION:

;; will return #t if "or" is special form, otherwise, if
;; all arguments are evaluated before passing to "or", it will "stuck"
;; cause of infinite recursion
(define (is-special-or?) (or #t (is-special-or?)))

;; will return #t if "and" is special form, otherwise, if
;; all arguments are evaluated before passing to "and", it will "stuck"
;; cause of infinite recursion
(define (is-special-and?) (not (and #f (is-special-and?))))

(is-special-or?)
(is-special-and?)

;; It will be advantageous for interpreter to treat "or" as a special form cause it
;; will not need to evaluate any predicates after first predicate that evalues to #t

;; It will be advantageous for interpreter to treat "or" as an ordinary form cause it
;; will not need to implement special forms in the interpreter code, just define "or" as 
;; an ordinary procedure.
