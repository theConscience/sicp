#lang sicp

(#%require rackunit)

; TASK:
;
; Удваивание
;
; Определите процедуру double , которая принимает как аргумент процедуру
; с одним аргументом и возвращает процедуру, которая применяет исходную
; процедуру дважды. Например, если процедура inc добавляет к своему аргументу
; 1 , то (double inc) должна быть процедурой, которая добавляет 2.
; Скажите, какое значение возвращает:
;
; (((double (double double)) inc) 5)


; SOLUTION:

(define (double f) (lambda (x) (f (f x))))


; HELPERS:

(define inc (lambda (x) (+ x 1)))


; TESTS:

(check-equal? ((double inc) 0) 2)

