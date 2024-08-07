(load "test")
(load "suit-strategy")
(load "stop-at")
(load "majority")

(define strategy-1 (stop-at 15))
(define strategy-2 (stop-at 17))
(define strategy-3 (suit-strategy 'h (stop-at 13) (stop-at 19)))

(define majority-strategy 
  (majority strategy-1 strategy-2 strategy-3))

(test "Strategy 1 and 2 return #t, Strategy 3 returns #f; majority should be #t"
      (majority-strategy '(9d 5d) 'ah) 
      #t)

(test "Strategy 2 and 3 return #t, Strategy 1 returns #f; majority should be #t"
      (majority-strategy '(9h 7d) 'ah) 
      #t)

(test "Strategy 1 and 3 return #f, Strategy 2 returns #t; majority should be #f"
      (majority-strategy '(10d 6d) 'ah) 
      #f)

(test "All strategies return #f; majority should be #f"
      (majority-strategy '(9d 8d) '9h) 
      #f)

(test "All strategies return #t; majority should be #t"
      (majority-strategy '(10h 4h) 'ah) 
      #t)

