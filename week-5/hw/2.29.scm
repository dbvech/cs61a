(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

;; TEST DATA
(define test-mobile
  (make-mobile (make-branch 2 4)
               (make-branch 3 (make-mobile (make-branch 1 10) (make-branch 1 20)))))

(define test-mobile-balanced
  (make-mobile (make-branch 3 4)
               (make-branch 2 (make-mobile (make-branch 1 3) (make-branch 1 3)))))

;; 1. Selectors
(define (left-branch m)
  (car m))
(define (right-branch m)
  (car (cdr m)))

(define (branch-length b)
  (car b))
(define (branch-structure b)
  (car (cdr b)))

;; 2. total-weight
(define (total-weight m)
  (cond
    ((null? m) 0)
    ((not (pair? m)) m)
    (else (+ (total-weight (branch-structure (left-branch m)))
             (total-weight (branch-structure (right-branch m)))))))

;; TESTS
(total-weight test-mobile) ; -> 34
(total-weight test-mobile-balanced) ; -> 10

;; 3. balanced?
(define (torque branch)
  (* (branch-length branch) (total-weight (branch-structure branch))))

(define (balanced? m)
  (if (not (pair? m))
    #t
    (let ((lb (left-branch m))
          (rb (right-branch m)))
      (and (= (torque lb) (torque rb))
           (balanced? (branch-structure lb))
           (balanced? (branch-structure rb))))))

;; TESTS
(balanced? test-mobile) ; -> #f
(balanced? test-mobile-balanced) ; -> t

;; 4. Suppose we change the representation of mobiles so that the constructors are: 
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

;; How much do you need to change your programs to convert to the new representation?
;; ANSWER: we need to change only selectors, since all the rest of code are not 
;; violating data abstraction
(define (left-branch m)
  (car m))
(define (right-branch m)
  (cdr m))

(define (branch-length b)
  (car b))
(define (branch-structure b)
  (cdr b))

;; TESTS
(define test-mobile
  (make-mobile (make-branch 2 4)
               (make-branch 3 (make-mobile (make-branch 1 10) (make-branch 1 20)))))

(define test-mobile-balanced
  (make-mobile (make-branch 3 4)
               (make-branch 2 (make-mobile (make-branch 1 3) (make-branch 1 3)))))

(total-weight test-mobile) ; -> 34
(total-weight test-mobile-balanced) ; -> 10

(balanced? test-mobile) ; -> #f
(balanced? test-mobile-balanced) ; -> t
