(load "test")
(load "stop-at")
(load "reckless")

;; Define a sample strategy to use with `reckless`
(define sample-strategy 
  (stop-at 17))

(define reckless-strategy 
  (reckless sample-strategy))

(test "Original strategy stands at 16, reckless strategy should take one more card if possible"
      (reckless-strategy '(9d 7d) 'ah) 
      #t)

(test "Original strategy doesn't stand at 19 but stands for previous hand which is 16, reckless strategy should take one more card if possible"
      (reckless-strategy '(9d 7d 3d) 'ah) 
      #t)

(test "Original strategy doesn't stand at 20, reckless strategy will not take one more card cause previous hand is 19 which is also #f for original strategy"
      (reckless-strategy '(9d 7d 3d 1d) 'ah) 
      #f)
