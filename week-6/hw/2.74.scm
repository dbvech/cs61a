(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
    (car datum)
    (error "Bad tagged datum: 
              TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
    (cdr datum)
    (error "Bad tagged datum: 
              CONTENTS" datum)))

;; 1. Each division need to attach a tag (eg. 'div-1, 'div-2) to each file
;; and provide install procedure to add it's data abstractions to "global" table

(define (test-division-install)
  (define (tag x) (attach-tag 'test-division x))

  (define (get-record file employee-name)
    ;; find record here, and then return it with tag
    (tag record))

  (define (get-salary record)
    (salary record))

  (put 'get-record '(test-division) get-record)
  (put 'get-salary '(test-division) get-salary))

(test-division-install)

(define (get-record file employee-name)
  (get 'get-record (type-tag file) (contents file)))

;; 2. Records should also contain a tag of division where it was created
(define (get-salary record)
  (get 'get-salary (type-tag record) (contents record)))

;; 3. 
(define (find-employee-record employee-name files-list)
  (if (null? files-list)
    #f
    (or (get-record (car files-list))
        (find-employee-record employee-name (cdr files-list)))))

;; 4. A new company must provide an installation procedure which will 
;; "register" (via put) it's implementations of get-record and get-salary
;; it should also "tag" all files and records that it returns from procedures
;; eg.
(define (new-company-install)
  (define (tag x) (attach-tag 'new-company x))

  (define (get-record file employee-name)
    ;; find record here, and then return it with tag
    (tag record))

  (define (get-salary record)
    (salary record))

  (put 'get-record '(new-company) get-record)
  (put 'get-salary '(new-company) get-salary))

(new-company-install)
