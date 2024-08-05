;; This lab exercise concerns the change counting program on pages 40–41 of Abelson and Sussman.
;; 1. Identify two ways to change the program to reverse the order in which coins are tried, 
;; that is, to change the program so that pennies are tried first, then nickels, then dimes,
;; and so on.

;; ORIGIN procedure (from the book)

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
    ((= kinds-of-coins 2) 5)
    ((= kinds-of-coins 3) 10)
    ((= kinds-of-coins 4) 25)
    ((= kinds-of-coins 5) 50)))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
    ((or (< amount 0)
         (= kinds-of-coins 0))
     0)
    (else
     (+ (cc amount (- kinds-of-coins 1))
        (cc (- amount (first-denomination
                       kinds-of-coins))
            kinds-of-coins)))))

;; ANSWER
;; The first way to change the order of coins is to change (reverse)
;; cond clauses in "first-denomination" procedure
(define (first-denomination-reversed kinds-of-coins)
  (cond ((= kinds-of-coins 1) 50)
    ((= kinds-of-coins 2) 25)
    ((= kinds-of-coins 3) 10)
    ((= kinds-of-coins 4) 5)
    ((= kinds-of-coins 5) 1)))

;; The second way is to modify `cc` procedure so it will iterate from 1 to kinds-of-coins
;; (instead of from kinds-of-coints to 0). For that we will need additional 
;; state parameter `i` (which will be using to get nomination) and thus helper function `iter`

(define (cc-reversed amount kinds-of-coins)
  (define (iter amount i)
    (cond ((= amount 0) 1)
      ((or (< amount 0)
           (> i kinds-of-coins))
       0)
      (else
       (+ (iter amount (+ i 1))
          (iter (- amount (first-denomination
                           i))
                i)))))
  ;; (trace iter)
  (iter amount 1))

;; test
;; (cc-reversed 100 5) ; -> 292


;; 2. Abelson and Sussman claim that this change would not affect the correctness 
;; of the computation. However, it does affect the efficiency of the computation. 
;; Implement one of the ways you devised in exercise 1 for reversing the order 
;; in which coins are tried, and determine the extent to which the number of calls 
;; to cc is affected by the revision. Verify your answer on the computer, and provide 
;; an explanation. Hint: limit yourself to nickels and pennies, and compare the 
;; trees resulting from (cc 5 2) for each order.
;; (trace cc)
;; (trace cc-reversed)
(cc 5 2) ; number of calls of cc here is 13
(cc-reversed 5 2) ; number of calls of iter (inner procedure of cc-reversed) is 21
;; which means that descending order of using nominals is more (computational) efficient 

;; 3. Modify the cc procedure so that its kinds-of-coins parameter, instead of being 
;; an integer, is a sentence that contains the values of the coins to be used in making change. 
;; The coins should be tried in the sequence they appear in the sentence. For the count-change 
;; procedure to work the same in the revised program as in the original, it should call cc as follows:
;; (define (count-change amount) 
;;   (cc amount ’(50 25 10 5 1)) )

(define (cc-sent amount kinds-of-coins)
  (cond ((= amount 0) 1)
    ((or (< amount 0)
         (empty? kinds-of-coins))
     0)
    (else
     (+ (cc-sent amount (bf kinds-of-coins))
        (cc-sent (- amount (first kinds-of-coins)) kinds-of-coins)))))

(define (count-change amount)
  (cc-sent amount '(50 25 10 5 1)))

;; test
;; (count-change 100) ; -> 292
