;; Five schoolgirls sat for an examination. 
;; Their parents—so they thought—showed an undue degree of interest 
;; in the result. They therefore agreed that, in writing home about 
;; the examination, each girl should make one true statement and one 
;; untrue one. The following are the relevant passages from their letters:
;;
;; Betty: “Kitty was second in the examination. I was only third.”
;; Ethel: “You’ll be glad to hear that I was on top. Joan was second.”
;; Joan: “I was third, and poor old Ethel was bottom.”
;; Kitty: “I came out second. Mary was only fourth.”
;; Mary: “I was fourth. Top place was taken by Betty.”
;;
;; What in fact was the order in which the five girls were placed?

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (liars)
  (define (one-true? a b)
    (if a (if b #f #t) b))
  (let ((betty (amb 1 2 3 4 5))
        (ethel (amb 1 2 3 4 5))
        (joan (amb 1 2 3 4 5))
        (kitty (amb 1 2 3 4 5))
        (mary (amb 1 2 3 4 5)))
    (require (distinct? (list betty ethel joan kitty mary)))
    (require (one-true? (= kitty 2)(= betty 3)))
    (require (one-true? (= ethel 1)(= joan 2)))
    (require (one-true? (= joan 3)(= ethel 5)))
    (require (one-true? (= kitty 2)(= mary 4)))
    (require (one-true? (= mary 4)(= betty 1)))
    (display "\nBetty: ")
    (display betty)
    (display "\nEthel: ")
    (display ethel)
    (display "\nJoan: ")
    (display joan)
    (display "\nKitty: ")
    (display kitty)
    (display "\nMary: ")
    (display mary)))

(liars)
;; Betty: 3
;; Ethel: 5
;; Joan: 2
;; Kitty: 1
;; Mary: 4
