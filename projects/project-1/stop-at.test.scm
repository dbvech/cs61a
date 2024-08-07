(load "test")
(load "stop-at")

(define test-stop-at-17 (stop-at 17))
(define test-stop-at-15 (stop-at 15))

(test "Should return #t for hand total < 17"
      (test-stop-at-17 '(5h 6s) 'kd)
      #t)

(test "Should return #f for hand total >= 17"
      (test-stop-at-17 '(8h 9s) 'kd)
      #f)

(test "Should return #t for hand total < 15"
      (test-stop-at-15 '(5h 6s) 'kd)
      #t)

(test "Should return #f for hand total >= 15"
      (test-stop-at-15 '(7h 8s) 'kd)
      #f)

(test "Should return #t for hand total < 17 with ace"
      (test-stop-at-17 '(ah 5s) 'kd)
      #t)

(test "Should return #f for hand total = 17"
      (test-stop-at-17 '(10h 7s) 'kd)
      #f)

(test "Should return #t for hand total = 16"
      (test-stop-at-17 '(9h 7s) 'kd)
      #t)
