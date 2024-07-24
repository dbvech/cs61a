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
