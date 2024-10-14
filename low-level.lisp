;;;; +----------------------------------------------------------------+
;;;; | cl-tree-sitter                                                 |
;;;; +----------------------------------------------------------------+

(defpackage #:cl-tree-sitter/low-level
  (:use #:cl)
  (:import-from
   #:cffi
   #:define-foreign-library
   #:use-foreign-library
   #:defctype
   #:defcenum
   #:defcstruct
   #:defcfun
   #:with-foreign-object
   #:foreign-slot-value)
  (:export
   #:tree-sitter
   #:ts-parser
   #:ts-language
   #:ts-tree
   #:ts-query
   #:ts-query-cursor
   #:ts-symbol
   #:ts-field-id
   #:ts-input-encoding
   #:ts-symbol-type
   #:ts-state-id
   #:ts-log-type
   #:ts-query-predicate-step-type
   #:ts-query-error
   #:ts-point
   #:row
   #:column
   #:ts-range
   #:ts-input
   #:ts-logger
   #:ts-input-edit
   #:ts-node
   #:ts-tree-cursor
   #:ts-query-capture
   #:ts-query-match
   #:ts-query-predicate-step
   #:ts-parser-new
   #:ts-parser-delete
   #:ts-parser-set-language
   #:ts-parser-language
   #:ts-parser-set-included-ranges
   #:ts-parser-included-ranges
   #:ts-parser-parse
   #:ts-parser-parse-string
   #:ts-parser-parse-string-encoding
   #:ts-parser-reset
   #:ts-parser-set-timeout-micros
   #:ts-parser-timeout-micros
   #:ts-parser-set-cancellation-flag
   #:ts-parser-set-logger
   #:ts-parser-logger
   #:ts-parser-print-dot-graphs
   #:ts-parser-halt-on-error
   #:ts-tree-copy
   #:ts-tree-delete
   #:ts-tree-language
   #:ts-tree-edit
   #:ts-tree-get-changed-ranges
   #:ts-node-symbol-pointer
   #:ts-node-start-byte-pointer
   #:ts-node-end-byte-pointer
   #:ts-node-string-pointer
   #:ts-node-parent-pointer
   #:ts-node-child-pointer
   #:ts-node-child-count-pointer
   #:ts-node-named-child-pointer
   #:ts-node-named-child-count-pointer
   #:ts-node-child-by-field-name-pointer
   #:ts-node-child-by-field-id-pointer
   #:ts-node-next-sibling-pointer
   #:ts-node-prev-sibling-pointer
   #:ts-node-next-named-sibling-pointer
   #:ts-node-prev-named-sibling-pointer
   #:ts-node-first-child-for-byte-pointer
   #:ts-node-first-named-child-for-byte-pointer
   #:ts-node-descendant-for-byte-range-pointer
   #:ts-node-descendant-for-point-range-pointer
   #:ts-node-named-descendant-for-byte-range-pointer
   #:ts-node-named-descendant-for-point-range-pointer
   #:ts-node-edit
   #:ts-tree-cursor-new
   #:ts-tree-cursor-delete
   #:with-tree-cursor
   #:ts-tree-cursor-reset-pointer
   #:ts-tree-cursor-current-node
   #:ts-tree-cursor-current-field-name
   #:ts-tree-cursor-current-field-id
   #:ts-tree-cursor-goto-parent
   #:ts-tree-cursor-goto-next-sibling
   #:ts-tree-cursor-goto-first-child
   #:ts-tree-cursor-goto-first-child-for-byte
   #:ts-tree-cursor-copy
   #:ts-language-symbol-count
   #:ts-language-symbol-name
   #:ts-language-symbol-for-name
   #:ts-language-field-count
   #:ts-language-field-name-for-id
   #:ts-language-field-id-for-name
   #:ts-language-symbol-type
   #:ts-language-version
   #:ts-language-copy
   #:ts-language-delete
   #:ts-language-state-count
   #:ts-language-is-wasm
   #:ts-language-next-state
   #:ts-tree-cursor-new-pointer
   #:ts-tree-root-node-pointer
   #:ts-node-is-named-pointer
   #:ts-tree-cursor-current-node-pointer
   #:ts-node-start-point-pointer
   #:ts-node-end-point-pointer
   #:ts-node-type-pointer
   #:ts-query-cursor-exec-pointer
   #:ts-node-language-pointer
   #:ts-node-field-name-for-child-pointer
   #:ts-node-descendant-count-pointer
   #:ts-node-next-parse-state-pointer
   #:ts-node-parse-state-pointer
   #:ts-node-has-error-pointer
   #:ts-node-has-changes-pointer
   #:ts-node-is-null-pointer
   #:ts-node-is-missing-pointer
   #:ts-node-is-extra-pointer
   #:ts-node-is-error-pointer
   #:ts-node-child-containing-descendant
   #:ts-node-grammar-type
   #:ts-node-grammar-symbol
   #:ts-node-eq
   #:ts-query-new
   #:ts-query-delete
   #:ts-query-pattern-count
   #:ts-query-capture-count
   #:ts-query-string-count
   #:ts-query-start-byte-for-pattern
   #:ts-query-end-byte-for-pattern
   #:ts-query-predicates-for-pattern
   #:ts-query-is-pattern-rooted
   #:ts-query-is-pattern-non-local
   #:ts-query-is-pattern-guaranteed-at-step
   #:ts-query-capture-name-for-id
   #:ts-query-capture-quantifier-for-id
   #:ts-query-string-value-for-id
   #:ts-query-disable-capture
   #:ts-query-disable-pattern
   #:ts-query-cursor-new
   #:ts-query-cursor-delete
   #:ts-query-cursor-did-exceed-match-limit
   #:ts-query-cursor-match-limit
   #:ts-query-cursor-set-match-limit
   #:ts-query-cursor-set-byte-range
   #:ts-query-cursor-next-match
   #:ts-query-cursor-remove-match
   #:ts-query-cursor-next-capture
   #:ts-query-cursor-set-max-start-depth
   #:ts-query-cursor-set-point-range-pointer
   #:ts-tree-cursor-goto-first-child-for-point-pointer
   #:ts-tree-root-node-with-offset-pointer))


(in-package #:cl-tree-sitter/low-level)

;; Library

(define-foreign-library tree-sitter
  (:darwin (:default "/usr/local/lib/libtree-sitter"))
  (t (:or (:default "tree-sitter") (:default "libtree-sitter"))))

(use-foreign-library tree-sitter)

(define-foreign-library (tree-sitter-wrapper
                         :search-path
                         (asdf:system-relative-pathname :cl-tree-sitter ""))
  (t (:default "tree-sitter-wrapper")))

(use-foreign-library tree-sitter-wrapper)

;; Types

(defctype ts-parser :pointer)

(defctype ts-language :pointer)

(defctype ts-tree :pointer)

(defctype ts-query :pointer)

(defctype ts-query-cursor :pointer)

(defctype ts-symbol :uint16)

(defctype ts-field-id :uint16)

(defctype ts-state-id :uint16)

;; Enums

(defcenum ts-input-encoding
  :utf-8
  :utf-16)

(defcenum ts-symbol-type
  :regular
  :anonymous
  :auxiliary)

(defcenum ts-log-type
  :parse
  :lex)

(defcenum ts-query-predicate-step-type
  :done
  :capture
  :string)

;; Structs

(defcstruct ts-point
  (row :uint32)
  (column :uint32))

(defcstruct ts-range
  (start-point (:struct ts-point))
  (end-point (:struct ts-point))
  (start-byte :uint32)
  (end-byte :uint32))

(defcstruct ts-input
  (payload :pointer)
  (read :pointer)
  (encoding ts-input-encoding))

(defcstruct ts-logger
  (payload :pointer)
  (log :pointer))

(defcstruct ts-input-edit
  (start-byte :uint32)
  (old-end-byte :uint32)
  (new-end-byte :uint32)
  (start-point (:struct ts-point))
  (old-end-point (:struct ts-point))
  (new-end-point (:struct ts-point)))

(defcstruct ts-node
  (context :uint32 :count 4)
  (id :pointer)
  (tree ts-tree))

(defcstruct ts-tree-cursor
  (tree :pointer)
  (id :pointer)
  (context :uint32 :count 2))

(defcstruct ts-query-capture
  (node (:struct ts-node))
  (index :uint32))

(defcstruct ts-query-match
  (id :uint32)
  (pattern-index :uint16)
  (capture-count :uint16)
  (captures (:pointer (:struct ts-query-capture))))

(defcstruct ts-query-predicate-step
  (type ts-query-predicate-step-type)
  (value-id :uint32))

;; Functions

(defcfun ts-parser-new ts-parser)

(defcfun ts-parser-delete :void
  (parser ts-parser))

(defcfun ts-parser-set-language :bool
  (parser ts-parser)
  (language ts-language))

(defcfun ts-parser-language ts-language
  (parser ts-parser))

(defcfun ts-parser-set-included-ranges :void
  (parser ts-parser)
  (ranges (:pointer (:struct ts-range)))
  (length :uint32))

(defcfun ts-parser-included-ranges (:pointer (:struct ts-range))
  (parser ts-parser)
  (length :uint32))

(defcfun ts-parser-parse ts-tree
  (parser ts-parser)
  (old-tree ts-tree)
  (input (:struct ts-input)))

(defcfun ts-parser-parse-string ts-tree
  (parser ts-parser)
  (old-tree ts-tree)
  (string :string)
  (length :uint32))

(defcfun ts-parser-parse-string-encoding ts-tree
  (parser ts-parser)
  (old-tree ts-tree)
  (string :string)
  (length :uint32)
  (encoding ts-input-encoding))

(defcfun ts-parser-reset :void
  (parser ts-parser))

(defcfun ts-parser-set-timeout-micros :void
  (parser ts-parser)
  (timeout :uint64))

(defcfun ts-parser-timeout-micros :uint64
  (parser ts-parser))

(defcfun ts-parser-set-cancellation-flag :pointer
  (parser ts-parser))

(defcfun ts-parser-set-logger :void
  (parser ts-parser)
  (logger (:struct ts-logger)))

(defcfun ts-parser-logger (:struct ts-logger)
  (parser ts-parser))

(defcfun ts-parser-print-dot-graphs :void
  (parser ts-parser)
  (file :int))

;; TODO: It doesn't exists in treesit api
(defcfun ts-parser-halt-on-error :void
  (parser ts-parser)
  (halt :bool))

(defcfun ts-tree-copy ts-tree
  (tree ts-tree))

(defcfun ts-tree-delete :void
  (tree ts-tree))

(defcfun ts-tree-language ts-language
  (tree ts-tree))

(defcfun ts-tree-edit :void
  (tree ts-tree)
  (edit (:struct ts-input-edit)))

(defcfun ts-tree-get-changed-ranges (:pointer (:struct ts-range))
  (old-tree ts-tree)
  (new-tree ts-tree)
  (length :pointer))

(defcfun ts-tree-cursor-goto-first-child-for-point-pointer :int64
  (self (:pointer (:struct ts-tree-cursor)))
  (goal_point (:pointer (:struct ts-point))))

(defcfun ts-tree-root-node-with-offset-pointer (:pointer (:struct ts-node))
  (self ts-tree)
  (offset_bytes :uint32)
  (offset_extent (:pointer (:struct ts-point))))

(defcfun ts-node-type-pointer :string
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-symbol-pointer ts-symbol
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-start-byte-pointer :uint32
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-end-byte-pointer :uint32
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-end-point-pointer (:pointer (:struct ts-point))
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-string-pointer :pointer
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-parent-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-child-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (index :uint32))

(defcfun ts-node-child-count-pointer :uint32
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-named-child-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (index :uint32))

(defcfun ts-node-named-child-count-pointer :uint32
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-child-by-field-name-pointer (:pointer (:struct ts-node))
  (self (:pointer (:struct ts-node)))
  (field-name :string)
  (field-name-length :uint32))

(defcfun ts-node-child-by-field-id-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (id ts-field-id))

(defcfun ts-node-next-sibling-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-prev-sibling-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-next-named-sibling-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-prev-named-sibling-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-first-child-for-byte-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (index :uint32))

(defcfun ts-node-first-named-child-for-byte-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (index :uint32))

(defcfun ts-node-descendant-for-byte-range-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (start :uint32)
  (end :uint32))

(defcfun ts-node-descendant-for-point-range-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (start (:pointer (:struct ts-point)))
  (end (:pointer (:struct ts-point))))

(defcfun ts-node-named-descendant-for-byte-range-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (start :uint32)
  (end :uint32))

(defcfun ts-node-named-descendant-for-point-range-pointer (:pointer (:struct ts-node))
  (node (:pointer (:struct ts-node)))
  (start (:pointer (:struct ts-point)))
  (end (:pointer (:struct ts-point))))

(defcfun ts-node-edit :void
  (node (:pointer (:struct ts-node)))
  (edit (:pointer (:struct ts-input-edit))))

(defcfun ts-tree-cursor-new (:struct ts-tree-cursor)
  (node (:struct ts-node)))

(defcfun ts-tree-cursor-delete :void
  (cursor (:pointer (:struct ts-tree-cursor))))

(defmacro with-tree-cursor ((var node) &body forms)
  (let ((cursor-lisp (gensym)))
    `(let ((,cursor-lisp (ts-tree-cursor-new ,node)))
       (with-foreign-object (,var '(:struct ts-tree-cursor))
         (setf (foreign-slot-value ,var '(:struct ts-tree-cursor) 'tree)
               (getf ,cursor-lisp 'tree))
         (setf (foreign-slot-value ,var '(:struct ts-tree-cursor) 'id)
               (getf ,cursor-lisp 'id))
         (setf (foreign-slot-value ,var '(:struct ts-tree-cursor) 'context)
               (getf ,cursor-lisp 'context))
         (unwind-protect
              (progn ,@forms)
           (ts-tree-cursor-delete ,var))))))

(defcfun ts-tree-cursor-reset-pointer :void
  (cursor (:pointer (:struct ts-tree-cursor)))
  (node (:pointer (:struct ts-node))))

(defcfun ts-tree-cursor-current-node (:struct ts-node)
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-tree-cursor-current-field-name :pointer
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-tree-cursor-current-field-id ts-field-id
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-tree-cursor-goto-parent :bool
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-tree-cursor-goto-next-sibling :bool
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-tree-cursor-goto-first-child :bool
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-tree-cursor-goto-first-child-for-byte :int64
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-tree-cursor-copy (:struct ts-tree-cursor)
  (cursor (:pointer (:struct ts-tree-cursor))))

;; Query section

(defcenum ts-query-error
  (:none 0)
  (:syntax 1)
  (:node-type 2)
  (:field 3)
  (:capture 4)
  (:structure 5)
  (:language 6))

(defcfun ts-query-new ts-query
  (language ts-language)
  (source :string)
  (source_len :uint32)
  (error_offset (:pointer :uint32))
  (error_type (:pointer ts-query-error)))


(defcfun ts-query-delete :void
  (self ts-query))


(defcfun ts-query-pattern-count :uint32
  (self ts-query))


(defcfun ts-query-capture-count :uint32
  (self ts-query))


(defcfun ts-query-string-count :uint32
  (self ts-query))


(defcfun ts-query-start-byte-for-pattern :uint32
  (self ts-query)
  (pattern_index :uint32))


(defcfun ts-query-end-byte-for-pattern :uint32
  (self ts-query)
  (pattern_index :uint32))


(defcenum ts-query-predicate-step-type
  (:done 0)
  (:capture 1)
  (:string 2))


(defcstruct (ts-query-predicate-step :size 8)
  (type ts-query-predicate-step-type :offset 0)
  (value_id :uint32 :offset 4))


(defcfun ts-query-predicates-for-pattern (:pointer (:struct ts-query-predicate-step))
  (self ts-query)
  (pattern_index :uint32)
  (step_count (:pointer :uint32)))


(defcfun ts-query-is-pattern-rooted :bool
  (self ts-query)
  (pattern_index :uint32))


(defcfun ts-query-is-pattern-non-local :bool
  (self ts-query)
  (pattern_index :uint32))


(defcfun ts-query-is-pattern-guaranteed-at-step :bool
  (self ts-query)
  (byte_offset :uint32))


(defcfun ts-query-capture-name-for-id :string
  (self ts-query)
  (index :uint32)
  (length (:pointer :uint32)))

(defcenum ts-quantifier
  (:zero 0)
  (:zero-or-one 1)
  (:zero-or-more 2)
  (:one 3)
  (:one-or-more 4))

(defcfun ts-query-capture-quantifier-for-id ts-quantifier
  (self ts-query)
  (pattern_index :uint32)
  (capture_index :uint32))


(defcfun ts-query-string-value-for-id :string
  (self ts-query)
  (index :uint32)
  (length (:pointer :uint32)))


(defcfun ts-query-disable-capture :void
  (self ts-query)
  (name :STRING)
  (length :uint32))


(defcfun ts-query-disable-pattern :void
  (self ts-query)
  (pattern_index :uint32))


(defcfun ts-query-cursor-new ts-query-cursor)


(defcfun ts-query-cursor-delete :void
  (self ts-query-cursor))

(defcfun ts-query-cursor-did-exceed-match-limit :bool
  (self ts-query-cursor))


(defcfun ts-query-cursor-match-limit :uint32
  (self ts-query-cursor))


(defcfun ts-query-cursor-set-match-limit :void
  (self ts-query-cursor)
  (limit :uint32))


(defcfun ts-query-cursor-set-byte-range :void
  (self ts-query-cursor)
  (start_byte :uint32)
  (end_byte :uint32))

(defcfun ts-query-cursor-set-point-range-pointer :void
  (self ts-query-cursor)
  (start_point (:pointer (:struct ts-point)))
  (end_point (:pointer (:struct ts-point))))

(defcfun ts-query-cursor-next-match :bool
  (self ts-query-cursor)
  (match (:pointer (:struct ts-query-match))))


(defcfun ts-query-cursor-remove-match :void
  (self ts-query-cursor)
  (match_id :uint32))


(defcfun ts-query-cursor-next-capture :bool
  (self ts-query-cursor)
  (match (:pointer (:struct ts-query-match)))
  (capture_index (:pointer :uint32)))


(defcfun ts-query-cursor-set-max-start-depth :void
  (self ts-query-cursor)
  (max_start_depth :uint32))


(defcfun ts-language-copy ts-language
  (self ts-language))

(defcfun ts-language-delete :void
  (self ts-language))

(defcfun ts-language-state-count :uint32
  (self ts-language))

(defcfun ts-language-is-wasm :bool
  (self ts-language))

(defcfun ts-language-next-state ts-state-id
  (self ts-language)
  (state ts-state-id)
  (symbol ts-symbol))

(defcfun ts-query-cursor-exec-pointer :void
  (self ts-query-cursor)
  (query ts-query)
  (node (:pointer (:struct ts-node))))


(defcfun ts-language-symbol-count :uint32
  (language ts-language))

(defcfun ts-language-symbol-name :string
  (language ts-language)
  (symbol ts-symbol))

(defcfun ts-language-symbol-for-name ts-symbol
  (language ts-language)
  (string :string)
  (length :uint32)
  (is-named :bool))

(defcfun ts-language-field-count :uint32
  (language ts-language))

(defcfun ts-language-field-name-for-id :string
  (language ts-language)
  (field-id ts-field-id))

(defcfun ts-language-field-id-for-name ts-field-id
  (language ts-language)
  (name :string)
  (length :uint32))

(defcfun ts-language-symbol-type ts-symbol-type
  (language ts-language)
  (symbol ts-symbol))

(defcfun ts-language-version :uint32
  (language ts-language))

;; tree-sitter wrapper

(defcfun ts-tree-root-node-pointer (:pointer (:struct ts-node))
  (tree ts-tree))

(defcfun ts-tree-cursor-new-pointer (:pointer (:struct ts-tree-cursor))
  (node (:pointer (:struct ts-node))))

(defcfun ts-tree-cursor-current-node-pointer (:pointer (:struct ts-node))
  (cursor (:pointer (:struct ts-tree-cursor))))

(defcfun ts-node-start-point-pointer (:pointer (:struct ts-point))
  (node (:pointer (:struct ts-node))))

(defcfun ts-node-child-containing-descendant (:pointer (:struct ts-node))
  (self (:pointer (:struct ts-node)))
  (descendant (:pointer (:struct ts-node))))

(defcfun ts-node-grammar-type :string
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-grammar-symbol ts-symbol
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-eq :bool
  (self (:pointer (:struct ts-node)))
  (other (:pointer (:struct ts-node))))

(defcfun ts-node-is-null-pointer :bool
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-is-named-pointer :bool
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-is-missing-pointer :bool
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-is-extra-pointer :bool
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-is-error-pointer :bool
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-has-changes-pointer :bool
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-has-error-pointer :bool
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-parse-state-pointer ts-state-id
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-field-name-for-child-pointer :string
  (self (:pointer (:struct ts-node)))
  (child_index :uint32))

(defcfun ts-node-next-parse-state-pointer ts-state-id
  (self (:pointer (:struct ts-node))))

(defcfun ts-node-descendant-count-pointer :uint32
    (self (:pointer (:struct ts-node))))

(defcfun ts-node-language-pointer ts-language
  (self (:pointer (:struct ts-node))))

;; TODO: not implemented
;; ts-lookahead-iterator-current-symbol
;; ts-lookahead-iterator-current-symbol-name
;; ts-lookahead-iterator-delete
;; ts-lookahead-iterator-language
;; ts-lookahead-iterator-new
;; ts-lookahead-iterator-next
;; ts-lookahead-iterator-reset
;; ts-lookahead-iterator-reset-state
;; ts-parser-cancellation-flag
;; ts-parser-set-wasm-store
;; ts-parser-take-wasm-store
;; ts-set-allocator
;; ts-tree-cursor-current-depth
;; ts-tree-cursor-current-descendant-index
;; ts-tree-cursor-goto-descendant
;; ts-tree-cursor-goto-last-child
;; ts-tree-cursor-goto-previous-sibling
;; ts-tree-cursor-reset-to
;; ts-tree-included-ranges
;; ts-tree-print-dot-graph
;; ts-wasm-store-delete
;; ts-wasm-store-language-count
;; ts-wasm-store-load-language
;; ts-wasm-store-new
