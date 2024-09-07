;; *NOTE* from dbvech, the author of https://github.com/dbvech/cs61a repository:
;; I adjusted code to work in STklos. The main thing that changed in Socket API is that
;; it no longer accepts a callbacks. So, I had to remove the callbacks (on socket events) 
;; and replace them using threads with loops.

;DEAL WITH:
;   EMPTY

;CLEANUP:
;   EMPTY

;POSSIBLE MESSAGES
;=================
;hello -- Used to initialize three-way handshake; client->server.
;welcome -- Lets client know server got "hello"; server->client.
;thanks -- Tells server that client is done logging in; client->server.
;goodbye -- Tells client that its connection to the server is gone; server->client.
;send-msg -- Informs server to send this message to another client; client->server.
;receive-msg -- Message to be received by client; server->client.
;logout -- Informs the server that the client is logging off; client->server.
;client-list -- List of clients logged into the server; server->client.


(load "im-common.scm")

;clients variable stores all known clients.
;It's a table of entries in the format ("client name" . client-socket)
(define clients (list '*table*))

;Data abstraction for above:
(define key car)
(define value cdr)

;server variable stores the server socket
(define server '())


(define (clients-add name sock thread)
  ;;;Add sock to the clients list bound to name
  ;
  ;Broadcasting the new client list is left up to other places in the code.
  ;This is done so as to function as the opposite to (clients-remove).
  ;
  (if (not (assoc name (cdr clients)))
    (begin (set-cdr! clients (cons (cons name (cons sock thread)) (cdr clients))) #t)
    #f))


(define (clients-remove name)
  ;;;Remove name from the clients list
  ;
  ;Broadcasting the new client list is left up to other places in the code.
  ;This is because if the server is shutting down the traffic created by 
  ;sending a new client list after every remove client could be a issue.
  ;
  (define (helper who table)
    ;Remove key-value pair from table, return its value.
    (cond ((null? (cdr table)) #f)
      ((equal? who (key (cadr table)))
       (let ((result (value (cadr table))))
         (set-cdr! table (cddr table))
         result))
      (else (helper who (cdr table)))))
  (let* ((client (helper name clients))
         (to-close-socket (car client))
         (to-close-thread (cdr client)))
        (if (not (socket-down? to-close-socket))
          (socket-shutdown to-close-socket #f))
        (thread-terminate! to-close-thread)))


(define (clients-find name)
  ;;;Return the socket bound to name; if the name does not exist, return #f
  (let ((result (assoc name (cdr clients))))
    (if result
      (value result)
      #f)))


(define (clients-list)
  ;;;Return a list of known client names.
  (map key (cdr clients)))


(define (clients-string)
  ;;;Returns a string of space-separated names of known clients.
  ;If the list is empty, "nil" is returned.
  (if (null? (cdr clients))
    "nil"
    (apply string-append (map (lambda (name) (string-append " " name))
                              (clients-list)))))


(define (im-server-start)
  ;;;Start the server.
  ;
  ;Set! server variable
  ;Set thunk for handling handshake with new client
  ;
  (define thread
    (make-thread
     (lambda () (let loop ()
                  (let ((ns (socket-accept server)))
                    (display (format #f "New client connecting.~%"))
                    (handshake ns)
                    (display (format #f "After handshake.~%"))
                    (loop))))))

  (display (format #f "~%Server starting...~%"))
  (set! server (make-server-socket 53535))
  (display (format #f "Server IP address: ~A, server port: ~A~%"
                   "localhost"
                   (socket-port-number server)))

  (thread-start! thread)

  (display (format #f "(im-server-start) done.~%~%")))


(define (im-server-close)
  ;;;Close  the server by no longer accepting connections,
  ;
  ;Remove thunk on server.
  ;Broadcast "goodbye" message.
  ;Close all client sockets.
  ;Close server socket.
  ;
  (display "Server shutting down...~%")
  (broadcast "goodbye" "")
  (for-each clients-remove (clients-list))
  (if (and server (not (socket-down? server)))
    (begin
     (socket-accept server #f)
     (socket-shutdown server #f)))
  (set! server #f)
  (set! clients #f)
  (display (format #f "(im-server-close) done.~%~%")))


(define (handshake sock)
  ;;;Handle the three-way handshake with a client.
  ;
  ;Handshaking should go as follows:
  ;client->server:
  ;"<command>hello</command><from>CLIENT</from><to>server</to><data></data>"
  ;server->client:
  ;"<command>welcome</command><from>server</from><to>CLIENT</to><data></data>"
  ;client->server:
  ;"<command>thanks</command><from>CLIENT</from><to>server</to><data></data>"
  ;
  ;Accept the socket connection.
  ;Check message is "hello".
  ;Send "welcome" message back.
  ;Check response message is "thanks".
  ;Call (register-client)
  ;
  ;; (socket-accept-connection sock)
  (display (format #f "Connection accepted for ~A...~%" sock))
  (let* ((read-port (socket-input sock))
         (write-port (socket-output sock))
         (msg (get-msg read-port)))
        (if (not msg)
          (socket-shutdown sock #f)
          (begin
           (cond ((not (string=? "hello" (xml-cdata "command" msg)))
                  ;Need to make sure that won't intercept messages from
                  ;other clients trying to connect.
                  (socket-shutdown sock #f))
             ((assoc (xml-cdata "from" msg) (cdr clients))
              (display (format #f "Name ~A already exists.~%"
                               (xml-cdata "from" msg)))
              (send-msg "server"
                        (xml-cdata "from" msg)
                        "sorry" "" write-port)
              (socket-shutdown sock #f))
             (else
              (display (format #f "Sending welcome message.~%"))
              (if (not (send-msg "server"
                                 (xml-cdata "from" msg)
                                 "welcome" "" write-port))
                (socket-shutdown sock #f)
                (begin
                 (set! msg (get-msg read-port))
                 (if (not msg)
                   (socket-shutdown sock #f)
                   (begin
                    ;If response from welcome is thanks, handshake is done.
                    ;Can add client as a known client.
                    (if (not (string=? "thanks" (xml-cdata "command" msg)))
                      (socket-shutdown sock #f)
                      (begin
                       (display (format #f "~A has logged on.~%"
                                        (xml-cdata "from" msg)))
                       (register-client (xml-cdata "from" msg)
                                        sock)))))))))))))


(define (register-client name sock)
  (define thread
    (make-thread
     (lambda () (handle-client name sock))))
  ;;;Store socket to client and start handling of the client socket.
  (display (format #f "~A (~A) is being registered...~%" name sock))
  (if (clients-add name sock thread)
    (begin
     (display (format #f "clients: ~A.~%" clients))
     ;; (handle-client name sock)
     (thread-start! thread)
     (broadcast "client-list" (clients-string))
     (display (format #f "~A is now registered.~%~%" name)))))


(define (handle-client name sock)
  ;;;Handle messages from the client.
  ;
  ;Only handles "send-msg" and "logout" messages.
  ;
  (let ((read-port (socket-input sock))
        (write-port (socket-output sock)))
    (let loop ()
      (let ((msg (get-msg read-port)))
        (display (format #f "LOOP NEW MESSAGE: ~A~%" msg))
        (if (not msg)
          (remove-client name)
          (begin
           (display (format #f "Received message: ~A~%" msg))
           (cond ;Unrecognized commands fall through the (cond).
             ((string=? "send-msg" (xml-cdata "command" msg))
              (send-command (xml-cdata "from" msg)
                            (xml-cdata "to" msg) "receive-msg"
                            (xml-cdata "data" msg)))
             ((string=? "logout" (xml-cdata "command" msg))
              (remove-client (xml-cdata "from" msg)))))))
      (loop))))
;; ))


(define (send-command from to cmd data)
  ;;;Sends msg to someone from someone.
  ;
  ;Make sure socket still good.
  ;Send message.
  ;
  (let* ((client (clients-find to))
         (to-sock (car client)))
        (display (format #f "Sending message to ~A (~A)...~%" to to-sock))
        (print to-sock)
        (if to-sock
          (let ((write-port (socket-output to-sock)))
            (display (format #f "Sending the command ~A to ~A from ~A.~%" cmd to from)) ;logging
            (if (not write-port)
              (remove-client to)
              (if (not (send-msg from to cmd data write-port))
                (remove-client to)))
            (display (format #f "message sent.~%~%"))))))


(define (remove-client who)
  ;;;Remove client from living clients and send out a new  list of clients.
  (display (format #f "Removing ~A as a client.~%" who))
  (clients-remove who)
  (broadcast "client-list" (clients-string))
  (display (format #f "~A removed as a client.~%~%" who)))


(define (broadcast cmd data)
  ;;;Send COMMAND to all clients containing DATA.
  (display (format #f "Broadcasting the command ~A with data ~A to all clients.~%"
                   cmd data))
  (for-each (lambda (name) (send-command server name cmd data))
            (clients-list))
  (display (format #f "Broadcast done.~%~%")))


(define (get-ip-address-as-string) "localhost")
