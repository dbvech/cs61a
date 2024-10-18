;; 1. the names of all people who are supervised by Ben Bitdiddle, together 
;; with their addresses;

;;; Query input:
(and (supervisor ?x (bitdiddle Ben))
     (address ?x ?y))

;;; Query results:
(and (supervisor (tweakit lem e) (bitdiddle ben))
     (address (tweakit lem e) (boston (bay state road) 22)))
(and (supervisor (fect cy d) (bitdiddle ben))
     (address (fect cy d) (cambridge (ames street) 3)))
(and (supervisor (hacker alyssa p) (bitdiddle ben))
     (address (hacker alyssa p) (cambridge (mass ave) 78)))

;; 2. all people whose salary is less than Ben Bitdiddle’s, together with 
;; their salary and Ben Bitdiddle’s salary;

;;; Query input:
(and (salary (bitdiddle ben) ?x)
     (salary ?y ?z)
     (lisp-value < ?z ?x))

;;; Query results:
(and (salary (bitdiddle ben) 60000)
     (salary (aull dewitt) 25000)
     (lisp-value < 25000 60000))
(and (salary (bitdiddle ben) 60000)
     (salary (cratchet robert) 18000)
     (lisp-value < 18000 60000))
(and (salary (bitdiddle ben) 60000)
     (salary (reasoner louis) 30000)
     (lisp-value < 30000 60000))
(and (salary (bitdiddle ben) 60000)
     (salary (tweakit lem e) 25000)
     (lisp-value < 25000 60000))
(and (salary (bitdiddle ben) 60000)
     (salary (fect cy d) 35000)
     (lisp-value < 35000 60000))
(and (salary (bitdiddle ben) 60000)
     (salary (hacker alyssa p) 40000)
     (lisp-value < 40000 60000))

;; 3. all people who are supervised by someone who is not in the computer 
;; division, together with the supervisor’s name and job.

;;; Query input:
(and (supervisor ?x ?y)
     (not (job ?y (computer . ?rest)))
     (job ?y . ?z))

;;; Query results:
(and (supervisor (aull dewitt) (warbucks oliver))
     (not (job (warbucks oliver) (computer . ?rest)))
     (job (warbucks oliver) (administration big wheel)))
(and (supervisor (cratchet robert) (scrooge eben))
     (not (job (scrooge eben) (computer . ?rest)))
     (job (scrooge eben) (accounting chief accountant)))
(and (supervisor (scrooge eben) (warbucks oliver))
     (not (job (warbucks oliver) (computer . ?rest)))
     (job (warbucks oliver) (administration big wheel)))
(and (supervisor (bitdiddle ben) (warbucks oliver))
     (not (job (warbucks oliver) (computer . ?rest)))
     (job (warbucks oliver) (administration big wheel)))


