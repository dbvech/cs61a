(load "test")
(load "dealer-sensitive")

(test "Should return #t for dealer 'a' and customer hand total < 17"
      (dealer-sensitive '(3h 4s) 'ah)
      #t)

(test "Should return #t for dealer '8' and customer hand total < 17"
      (dealer-sensitive '(5h 9s) '8d)
      #t)

(test "Should return #f for dealer '10' and customer hand total >= 17"
      (dealer-sensitive '(9h 8s) '10c)
      #f)

(test "Should return #f for dealer '2' and customer hand total >= 12"
      (dealer-sensitive '(6h 6s) '2d)
      #f)

(test "Should return #t for dealer '5' and customer hand total < 12"
      (dealer-sensitive '(4h 6s) '5d)
      #t)

(test "Should return #f for dealer '5' and customer hand total >= 12"
      (dealer-sensitive '(7h 5s) '5d)
      #f)

(test "Should return #t for dealer '2' and customer hand total < 12"
      (dealer-sensitive '(3h 7s) '2d)
      #t)

(test "Should return #f for dealer 'j' and customer hand total >= 17"
      (dealer-sensitive '(9h 8s) 'jd)
      #f)

(test "Should return #f for dealer '4' and customer hand total >= 12"
      (dealer-sensitive '(7h 5s) '4d)
      #f)

(test "Should return #t for dealer '3' and customer hand total < 12"
      (dealer-sensitive '(2h 6s 3d) '3h)
      #t)
