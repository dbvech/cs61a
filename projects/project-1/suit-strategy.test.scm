(load "test")
(load "suit-strategy")
(load "stop-at")

(define test-strategy 
  (suit-strategy 
    'h 
    (stop-at 17) 
    (stop-at 19)))

(test "Customer's best total is 16 and no hearts, should return #t" 
      (test-strategy '(9d 7d) 'ah) 
      #t)

(test "Customer's best total is 18 and has a card of hearts, should return #t" 
      (test-strategy '(9h 9d) 'ah) 
      #t)

(test "Customer's best total is 18 and no hearts, should return #f" 
      (test-strategy '(9d 9s) 'ah) 
      #f)

(test "Customer's best total is 20 and has a card of hearts, should return #f" 
      (test-strategy '(10h 10d) 'ah) 
      #f)

(test "Customer's best total is 15 and has a card of hearts, should return #t" 
      (test-strategy '(7h 8d) 'ah) 
      #t)

(test "Customer's best total is 17 and no hearts, should return #f" 
      (test-strategy '(10d 7d) 'ah) 
      #f)

(test "Customer's best total is 17 and has a card of hearts, should return #t" 
      (test-strategy '(10d 7h) 'ah) 
      #t)

(test "Customer's best total is 19 and has a card of hearts, should return #f" 
      (test-strategy '(10d 9h) 'ah) 
      #f)

(define another-strategy 
  (suit-strategy 
    's 
    (stop-at 15) 
    (stop-at 20)))

(test "Customer's best total is 14 and no spades, should return #t" 
      (another-strategy '(9d 5h) 'ah) 
      #t)

(test "Customer's best total is 16 and has a card of spades, should return #t" 
      (another-strategy '(7s 9d) 'ah) 
      #t)

(test "Customer's best total is 16 and no spades, should return #f" 
      (another-strategy '(7d 9h) 'ah) 
      #f)

(test "Customer's best total is 19 and has a card of spades, should return #t" 
      (another-strategy '(10s 9d) 'ah) 
      #t)

(test "Customer's best total is 14 and has a card of spades, should return #t" 
      (another-strategy '(7s 7d) 'ah) 
      #t)

(test "Customer's best total is 16 and no spades, should return #f" 
      (another-strategy '(10d 6h) 'ah) 
      #f)

(test "Customer's best total is 15 and no spades, should return #f" 
      (another-strategy '(8d 7h) 'ah) 
      #f)

(test "Customer's best total is 20 and has a card of spades, should return #f" 
      (another-strategy '(10s 10d) 'ah) 
      #f)

(test "Customer's best total is 16 and no hearts, should return #t" 
      (valentine-strategy '(9d 7d) 'ah) 
      #t)

(test "Customer's best total is 18 and has a card of hearts, should return #t" 
      (valentine-strategy '(9h 9d) 'ah) 
      #t)

(test "Customer's best total is 18 and no hearts, should return #f" 
      (valentine-strategy '(9d 9s) 'ah) 
      #f)

(test "Customer's best total is 20 and has a card of hearts, should return #f" 
      (valentine-strategy '(10h 10d) 'ah) 
      #f)

(test "Customer's best total is 15 and has a card of hearts, should return #t" 
      (valentine-strategy '(7h 8d) 'ah) 
      #t)

(test "Customer's best total is 17 and no hearts, should return #f" 
      (valentine-strategy '(10d 7d) 'ah) 
      #f)

(test "Customer's best total is 17 and has a card of hearts, should return #t" 
      (valentine-strategy '(10d 7h) 'ah) 
      #t)

(test "Customer's best total is 19 and has a card of hearts, should return #f" 
      (valentine-strategy '(10d 9h) 'ah) 
      #f)

