(include "__baselib.scm")

; Import an external library:
(!import-from math factorial)

; Run some statements:
(!s "print(\"Running an statement!\")")
(display "This is a test text.\n")

; Call external library:
(display "Factorial of 10 is: ")
(display (!xa factorial 10))
(display "\n")
