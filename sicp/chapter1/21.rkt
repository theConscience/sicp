#lang sicp

(#%require rackunit)

; TASK:
;
; С помощью процедуры smallest-divisor найдите наименьший делитель следующих
; чисел: 199, 1999, 19999.


(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))


; SOLUTION:

; Ответы:
; для 199 — 199 (простое число)
; для 1999 — 1999 (простое число)
; для 19999 — 7

(smallest-divisor 199)

; # call 1
; (find-divisor 199 2)
;
; (cond ((> (square test-divisor) n) n)
;       ((divides? test-divisor n) test-divisor)
;       (else (find-divisor n (+ test-divisor 1))))
;
; (cond ((> (square 2) 199) 199)
;       ((divides? 2 199) 2)
;       (else (find-divisor 199 (+ 2 1))))
;
; (cond ((> 4 199) 199)                        #f
;       ((= (remainder 199 2) 0) 2)
;       (else (find-divisor 199 (+ 2 1))))

; (cond ((> 4 199) 199)                        #f
;       ((= 1 0) 2)                            #f
;       (else (find-divisor 199 (+ 2 1))))

; # call 2
; (find-divisor 199 (+ 2 1))
;
; (cond ((> (square (+ 2 1)) 199) 199)
;       ((divides? (+ 2 1) 199) (+ 2 1))
;       (else (find-divisor 199 (+ (+ 2 1) 1))))
;
; (cond ((> 9 199) 199)                       #f
;       ((= (remainder 199 3) 0) 3)
;       (else (find-divisor 199 (+ (+ 2 1) 1))))
;
; (cond ((> 9 199) 199)                       #f
;       ((= 1 0) 3)                           #f
;       (else (find-divisor 199 (+ (+ 2 1) 1))))

; # call 3

; (find-divisor 199 (+ (+ 2 1) 1))
;
; (cond ((> (square (+ (+ 2 1) 1)) 199) 199)
;       ((divides? (+ (+ 2 1) 1) 199) (+ (+ 2 1) 1))
;       (else (find-divisor 199 (+ (+ (+ 2 1) 1) 1))))
;
; (cond ((> 16 199) 199)                      #f
;       ((= (remainder 199 4) 4)              #f
;       (else (find-divisor 199 (+ (+ (+ 2 1) 1) 1))))
;
;
