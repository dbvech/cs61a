(load "test")
(load "stop-at-17")

(test "Should return #f" (stop-at-17 '(ad 8s) 'ad) #f)
(test "Should return #t" (stop-at-17 '(ad 8s 5h) 'ad) #t)
(test "Should return #f" (stop-at-17 '(ad as 9h) 'ad) #f)
(test "Should return #t" (stop-at-17 '(10h 6h) 'ad) #t)
(test "Should return #f" (stop-at-17 '(10h 7h) 'ad) #f)
(test "Should return #f" (stop-at-17 '(10h 8h) 'ad) #f)
