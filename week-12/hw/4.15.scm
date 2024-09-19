(define (run-forever)
  (run-forever))

(define (try p)
  (if (halts? p p)
    (run-forever)
    'halted))

;; invoking (try try) will become:
(if (halts? try try) ; <- inside try
  (run-forever)
  'halted)

;; suppose "halts?" returns true for the procedure "try" (means that procedure 
;; "try" halts on object "try"). Then "if" expression will invoke (run-forever)
;; and thus (try try) will run FOREVER, means that procedure "try" is NOT 
;; halts on object "try" which is different from what (halts? try try) returned.

;; suppose (halts? try try) returns false for the procedure "try" (means that procedure 
;; "try" dosn't halt on object "try"). Then "if" expression will return 'halted,
;; means that procedure "try" is HALTS on object "try" which is (again) 
;; different from what (halts? try try) returned.
