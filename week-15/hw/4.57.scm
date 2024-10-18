;; Define a rule that says that person 1 can replace person 2 if either 
;; person 1 does the same job as person 2 or 

;; someone who does person 1’s job 
;; can also do person 2’s job, and if person 1 and person 2 are not the same 
;; person. Using your rule, give queries that find the following:

(assert! (rule (can-replace ?p1 ?p2)
               (and (or (and (job ?p2 ?j2)
                             (job ?p1 ?j2))
                        (and (job ?p1 ?j1)
                             (job ?p2 ?j2)
                             (can-do-job ?j1 ?j2)))
                    (not (same ?p1 ?p2)))))

;; 1. all people who can replace Cy D. Fect;

;;; Query input:
(can-replace ?who (fect cy d))

;;; Query results:
(can-replace (bitdiddle ben) (fect cy d))
(can-replace (hacker alyssa p) (fect cy d))

;; 2. all people who can replace someone who is being paid more than they are, 
;; together with the two salaries.

;;; Query input:
(and (can-replace ?p1 ?p2)
     (salary ?p1 ?s1)
     (salary ?p2 ?s2)
     (lisp-value > ?s2 ?s1))

;;; Query results:
(and (can-replace (aull dewitt) (warbucks oliver))
     (salary (aull dewitt) 25000)
     (salary (warbucks oliver) 150000)
     (lisp-value > 150000 25000))
(and (can-replace (fect cy d) (hacker alyssa p))
     (salary (fect cy d) 35000)
     (salary (hacker alyssa p) 40000)
     (lisp-value > 40000 35000))
