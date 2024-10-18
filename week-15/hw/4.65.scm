;; Cy D. Fect, looking forward to the day when he will rise in the 
;; organization, gives a query to find all the wheels (using the wheel 
;; rule of 4.4.1):

(wheel ?who)
To his surprise, the system responds

;;; Query results:
(wheel (Warbucks Oliver))
(wheel (Bitdiddle Ben))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))

;; Why is Oliver Warbucks listed four times?

(assert!
 (rule (wheel ?person)
       (and (supervisor ?middle-manager ?person)
            (supervisor ?x ?middle-manager))))

;; The rule "wheel" is listing person the same number of times as there are
;; combinations existing where person is a supervisor of someone who also 
;; is a supervisor of someone. So,

;; Oliver Warbucks is a supervisor of:
;; - Bitdiddle Ben
;; - Scrooge Eben 
;; - Aull DeWitt

;; Bitdiddle Ben is a supervisor of 3 persons (Hacker Alyssa P, Fect Cy D and 
;; Tweakit Lem E), so it's a reson for Warbucks Oliver to be listed 3 times
;; in query results

;; Scrooge Eben is a supervisor of Cratchet Robert, so it is a reason for 
;; Warbucks Oliver to be listed another 1 time in query results

;; Aull DeWitt is not a supervisor, so 0 times here

;;                                  Warbucks Oliver
;;                                  /      |       \
;;                                 /       |        \
;;                                /        |         \
;;                               /         |          \
;;                  Bitdiddle Ben     Scrooge Eben    Aull DeWitt (not a supervisor)
;;                /      |       \          \            \
;;               /       |        \          \            \
;;              /        |         \          \            0
;;             /         |          \          \
;; Hacker Alyssa P   Fect Cy D  Tweakit Lem E   Cratchet Robert
;;         1             2            3               4
