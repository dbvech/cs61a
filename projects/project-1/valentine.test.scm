(load "test")
(load "valentine")

(test "Customer's best total is 17 and no hearts, should return #f" 
      (valentine '(10d 7d) 'ah) 
      #f)

(test "Customer's best total is 17 and no hearts, should return #t"
      (valentine '(10d 7h) 'ah)
      #t)

(test "Customer's best total is 19 and has card of hearts, should return #f" 
      (valentine '(10d 9h) 'ah) 
      #f)

(test "Customer's best total is 16 and no hearts, should return #t" 
      (valentine '(9d 7d) 'ah) 
      #t)

(test "Customer's best total is 18 and has a card of hearts, should return #t" 
      (valentine '(9h 9d) 'ah) 
      #t)

(test "Customer's best total is 18 and no hearts, should return #f" 
      (valentine '(9d 9s) 'ah) 
      #f)

(test "Customer's best total is 20 and has a card of hearts, should return #f" 
      (valentine '(10h 10d) 'ah) 
      #f)

(test "Customer's best total is 15 and has a card of hearts, should return #t" 
      (valentine '(7h 8d) 'ah) 
      #t)

