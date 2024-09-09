;; This task can be implemented either: only on client OR on client and server.
;; I decided to do it on both to reduce number of network requests and to persist
;; user's block list, since clients can disconnect and reconnect (which will remove local block list)
;; but the server should remain running and will keep block list.
;;
;; In case of client only implementation there will be 4 requests for each message that would be sent
;; by blocked user. Let's say user A is blocked user B, and user B is trying to send a message to user A
;; 1) user B sends a request to server asking to send message to user A
;; 2) server sends a request with user's B message to user A 
;; 3) the client code of user's A sees that user B is in block list and sends a request to server
;;    with "refuse" message to user B
;; 4) server sends a request with "refusal" message from user A to user B
;;
;; Same example in case of server + client implementation:
;; 1) user B sends a request to server asking to send message to user A
;; 2) server sees that user B is blocked by user A, and sends back to user B "refusal" message
;;
;; So with this implementation there is 2 times less requests (2 vs 4)


;; changes in im-server.scm
;; - add new data abstraction for blocked users
;;   (define block-table (list '*table*))
;;   
;;   (define (add-to-block-table! user-to-block requester)
;;     (let ((record (assoc requester (cdr block-table))))
;;       (cond
;;         ((not record)
;;          (set-cdr! block-table (cons (cons requester (list user-to-block)) (cdr block-table))))
;;         ((member user-to-block record)) ; already banned
;;         (else (set-cdr! record (cons user-to-block (cdr record)))))))
;;   
;;   (define (is-banned? sender receiver)
;;     (let ((ban-list (assoc receiver (cdr block-table))))
;;       (and ban-list (member sender (cdr ban-list)))))
;;
;; - new cond clause in handle-client procedure
;;   ...
;;   ((string=? "block-user" (xml-cdata "command" msg))
;;    (block-user (xml-cdata "to" msg)
;;                (xml-cdata "from" msg)))
;;   ...
;;
;; - new procedure block-user
;;   (define (block-user user requester)
;;     (if (equal? user requester)
;;       (send-command "*server*" requester "receive-msg" "Cannot self-block")
;;       (add-to-block-table! user requester)))
;;
;; - check if user is banned in send-command procedure (change in uppercase)
;;   (define (send-command from to cmd data)
;;     (IF (IS-BANNED? FROM TO)
;;       (SEND-COMMAND "*SERVER*" FROM "RECEIVE-MSG" (STRING-APPEND "YOUR MESSAGE WAS REFUSED BY " TO))
;;       (let* ((client (clients-find to))
;;              (to-sock (car client)))
;;             (display (format #f "Sending message to ~A (~A)...~%" to to-sock))
;;             (if to-sock
;;               (let ((write-port (socket-output to-sock)))
;;                 (display (format #f "Sending the command ~A to ~A from ~A.~%" cmd to from)) ;logging
;;                 (if (not write-port)
;;                   (remove-client to)
;;                   (if (not (send-msg from to cmd data write-port))
;;                     (remove-client to)))
;;                 (display (format #f "message sent.~%~%")))))))

;; changes in im-client.scm
;; - add new procedure to block users
;;   (define (im-block who)
;;     (if (not (send-msg whoiam who "block-user" "" to-server-write))
;;       (close-connection)
;;       #t)))
