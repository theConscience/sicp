#lang sicp

(#%require rackunit)

; TASK:
;
; Упражнение 1.42.
;
; Пусть f и g — две одноаргументные функции. По определению, композиция
; (composition) f и
; g есть функция x 7→ f(g(x)). Определите процедуру compose которая реализует
; композицию.
; Например, если inc — процедура, добавляющая к своему аргументу 1,
; ((compose square inc) 6)    -> 49


; SOLUTION:

#| (define (compose x) (lambda (f) (lambda (g) (f (g x))))) |#
(define (compose f g) (lambda (x) (f (g x))))


; HELPERS:

(define inc (lambda (x) (+ x 1)))
(define square (lambda (x) (* x x)))


; TESTS:


(check-equal? ((compose square inc) 6) 49)
