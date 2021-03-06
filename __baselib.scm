; Javascript statement
(define-macro (!s . params) `(##inline-host-statement ,@params))

; Javascript expression
(define-macro (!e . params) `(##inline-host-expression ,@params))

; javascript expression
(define-macro (!x . params) `(##inline-host-expression ,@params))

; Statement Apply (used to call functions as statements in a more Schemey way)
(define-macro (!sa name . args)
  (let 
    ((r (lambda (params) 
          (let ((sz (length params)))
            (let loop ((i 0) (res "") (initializer ""))
              (if (= i sz) 
                  res
                  (loop (+ i 1) 
                        (string-append 
                          res
                          initializer 
                          "g_scm2host(@" 
                          (number->string (+ i 1)) 
                          "@)")
                        ",")))))))
  (if (symbol? name) 
      `(##inline-host-statement 
        ,(string-append (symbol->string name) "(" (r args) ");") 
        ,@args)
      `(##inline-host-statement 
        ,(string-append name "(" (r args) ")") 
        ,@args))))

; Expression Apply (used to call functions as expressions in a more Schemey way)
(define-macro (!ea name . args)
  (let 
    ((r (lambda (params) 
          (let ((sz (length params)))
            (let loop ((i 0) (res "") (initializer ""))
              (if (= i sz) 
                  res
                  (loop (+ i 1) 
                        (string-append 
                          res
                          initializer 
                          "g_scm2host(@" 
                          (number->string (+ i 1)) 
                          "@)")
                        ",")))))))

  (if (symbol? name) 
      `(##inline-host-expression 
        ,(string-append (symbol->string name) "(" (r args) ")") 
        ,@args)
      `(##inline-host-expression 
        ,(string-append name "(" (r args) ")") 
        ,@args))))

; Expression Apply (used to call functions as expressions in a more Schemey way)
(define-macro (!xa name . args)
  (let 
    ((r (lambda (params) 
          (let ((sz (length params)))
            (let loop ((i 0) (res "") (initializer ""))
              (if (= i sz) 
                  res
                  (loop (+ i 1) 
                        (string-append 
                          res
                          initializer 
                          "g_scm2host(@" 
                          (number->string (+ i 1)) 
                          "@)")
                        ",")))))))
                        
  (if (symbol? name) 
      `(##inline-host-expression 
        ,(string-append (symbol->string name) "(" (r args) ")") 
        ,@args)
      `(##inline-host-expression
        ,(string-append name "(" (r args) ")") 
        ,@args))))

; Import macro:
(define-macro (!import-from library name)
  (let ((l (if (##symbol? library) (symbol->string library) library))
        (n (if (##symbol? name) (symbol->string name) name)))
    `(##inline-host-statement ,(string-append "from " l " import " n))))

(define-macro (!import library)
  (let ((l (if (##symbol? library) (symbol->string library) library)))
    `(##inline-host-statement ,(string-append "import " l ))))

