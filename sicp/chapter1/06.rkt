#lang sicp

; TASK:
; Сможет ли функция sqrt-iter работать в варианте new-sqrt-iter,
; в котором `if` заменен на `new-if` реализованный через `cond` ?
;

(define (square x) (* x x))

(define (abs x) (if (< x 0) (- x) x))

(define (average x y) (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enought? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enought? guess x)
      guess
      (sqrt-iter (improve guess x) x))) #| recursion! |#

(define (sqrt x) (sqrt-iter 1.0 x))


; SOLUTION:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (new-sqrt-iter guess x)
  (new-if (good-enought? guess x)
          guess
          (sqrt-iter (improve guess x) x))) #| recursion! |#

(define (new-sqrt x) (new-sqrt-iter 1.0 x))

; Не сможет, т.к. в отличие от cond if не пытается развернуть альтернативную
; операцию до тех пор, пока проверка предиката не провалилась. Соответственно
; рекурсионный случай в случае if не будет вызываться, когда условие выхода
; сработает. А в случае с cond-реализацией new-if такого происходить не будет,
; и программа попадет в бесконечную рекурсию, т.к. альтернатива всегда будет
; разворачиваться, вне зависимости от значения предиката.
