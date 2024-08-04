; 1
(define (get-numbers-sent int)
  (if (= int 0)
    '()
    (se int (get-numbers-sent (- int 1)))))

(define (number-of-partitions int)
  (define (loop amount numbers)
    (cond
      ((= amount 0) 1)
      ((or (< amount 0)
           (empty? numbers)) 0)
      (else
       (+ (loop (- amount (first numbers)) numbers)
          (loop amount (bf numbers))))))
  (loop int (get-numbers-sent int)))

(number-of-partitions 0)
(number-of-partitions 5)

; 2
; Counting partitions is like making change, where the coins are
; all integers from 1 to N (include) where N is the number for which
; partitions are counting

; 3
; Task: Now write it to generate an iterative process; every recursive call must be a tail call.
;
; Solution: I was able to achieve "iterative process" for the number-of-partitions procedure
; using two additional stacks (can be done with one):
; `amounts-stack` - to track amounts which needs to be proceeded
; `numbers-stack` - to track numbers (nominals) for corresponding amounts (from amounts-stack)
; I use '- (word) as a delimiter in numbers-stack like this:
; ('- 5 4 3 2 1 '- 4 3 2 1) which means there is two sequences (5 4 3 2 1) and (4 3 2 1)
; there are helper procedures to get last sentence and remove last sentence from stack
; 
; Example: 
; (number-of-partitions-iter 5)
; (loop '(5) '(5 4 3 2 1) 0) - 1st invokation of loop
; here we splitted 5(5,4,3,2,1) into two problems 0(5,4,3,2,1) and 5(4,3,2,1)
; (loop '(0 5) '(- 5 4 3 2 1 - 4 3 2 1) 0) - 2nd invokation of loop
; now we pop last pair - amount 5 and numbers (4,3,2,1) and process it
; which creates two other pairs - 1(4,3,2,1) and 5(3,2,1)
; (loop '(0 1 5) '(- 5 4 3 2 1 - 4 3 2 1 - 3 2 1) 0) - 3rd invokation of loop
; and so on...

(define (get-sent-from-stack stack)
  (define (loop stack sent)
    (if (or (empty? stack) (eq? (last stack) '-))
      sent
      (loop (bl stack) (se (last stack) sent))))
  (loop stack '()))

(define (remove-sent-from-stack stack)
  (cond ((empty? stack) '())
    ((eq? (last stack) '-) (bl stack))
    (else (remove-sent-from-stack (bl stack)))))

(define (number-of-partitions-iter i)
  (define (loop amounts-stack numbers-stack answer)
    (if (empty? amounts-stack)
      answer
      (let ((amount (last amounts-stack))
            (numbers (get-sent-from-stack numbers-stack))
            (next-amounts-stack (bl amounts-stack))
            (next-numbers-stack (remove-sent-from-stack numbers-stack)))
        (cond
          ((= amount 0) (loop next-amounts-stack next-numbers-stack (+ answer 1)))
          ((or (< amount 0)
               (empty? numbers)) (loop next-amounts-stack next-numbers-stack answer))
          (else (loop
                  (se next-amounts-stack (- amount (first numbers)) amount)
                  (se next-numbers-stack '- numbers '- (bf numbers))
                  answer))))))
  (loop (se i) (get-numbers-sent i) 0))


(number-of-partitions-iter 0)
(number-of-partitions-iter 5)
