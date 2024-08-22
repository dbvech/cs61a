;; GENERIC OPERATIONS WITH EXPLICIT DISPATCH
;; - add new types of data objects:
;;   1. write constructor (+tag) 
;;   2. write selectors for generic operations
;;   3. modify each generic operation to handle new data type
;;
;; - add new operations: 
;;   1. write implementation of new operation for each type of data objects
;;   2. write general operation with clauses to handle all existing types of data objects


;; DATA-DIRECTED STYLE
;; - add new types of data objects: 
;;   1. write constructor (+tag)
;;   2. write selectors for generic operations
;;   3. "register" constructor and selectors in "table" (PUT)
;;
;; - add new operations: 
;;   1. write implementation of new operation for each type of data objects 
;;   2. register in table (PUT) (adding general operation are not required)


;; MESSAGE-PASSING-STYLE
;; - add new types of data objects: 
;;   1. write constructor that returns dispatch ("selectors" inside)
;;
;; - add new operations: 
;;   1. modify each dispatch constructor to handle new operation type


;; Q: Which organization would be most appropriate for a system in which new types must often be added? 
;; A: data-directed and message-passing styles would be most appropriate cause
;;    don't involve modifying  existing code.

;; Q: Which would be most appropriate for a system in which new operations must often be added?
;; A: the most appropriate would be data-directed style cause doesn't involve modifying existing code.
