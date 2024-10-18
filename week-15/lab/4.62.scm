;;; Query input:
(assert! (rule (last-pair (?x) ?x)))

;; Assertion added to data base.

;;; Query input:
(assert! (rule (last-pair (?first . ?rest) ?x)
               (last-pair ?rest ?x)))

;;; Assertion added to data base.

;;; Query input:
(last-pair (1 2 3) ?x)

;;; Query results:
(last-pair (1 2 3) 3)

;;; Query input:
(last-pair (2 ?x) (3))

;;; Query results:
(last-pair (2 (3)) (3))

;; Do your rules work correctly on queries such as (last-pair ?x (3))?

;;; Query input:
(last-pair ?x (3))

;;; Query results:
;;; Error

;; ANSWER: No, it falls into infinite loop, cause of second rule:
;; (rule (last-pair (?first . ?rest) ?x)
;;       (last-pair ?rest ?x))

;; here ?x become (3)
;; (rule (last-pair (?first . ?rest) (3))
;;       (last-pair ?rest (3))) <- "recursive" call here
