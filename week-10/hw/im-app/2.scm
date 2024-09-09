;; im-client.scm
;; - new procedure "im-broadcast"
(define (im-broadcast message)
  (if (not (send-msg whoiam "server" "broadcast" message to-server-write))
    (close-connection)
    #t))

;; im-server.scm
;; - add new clause in "handle-server" procedure
(cond
  ((string=? "send-msg" (xml-cdata "command" msg))
   (send-command (xml-cdata "from" msg)
                 (xml-cdata "to" msg) "receive-msg"
                 (xml-cdata "data" msg)))
  ((STRING=? "BROADCAST" (XML-CDATA "COMMAND" MSG)) ;; <- new clause
   (FOR-EACH
    (LAMBDA (CLIENT)
            (SEND-COMMAND (XML-CDATA "FROM" MSG)
                          CLIENT "RECEIVE-MSG"
                          (XML-CDATA "DATA" MSG)))
    (CLIENTS-LIST)))
  ((string=? "logout" (xml-cdata "command" msg))
   (remove-client (xml-cdata "from" msg)))))))


