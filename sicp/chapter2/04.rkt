#lang sicp

(#%require rackunit)

; TASK:
;
; Процедурное представление пар
; Вот еще одно процедурное представление для пар. Проверьте для этого
; представления, что (car (cons x y)) возвращает x при любых двух объектах
; x и y .

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

; Каково соответствующее определение cdr?
; (Подсказка: Чтобы проверить, что это работает,
; используйте подстановочную модель из раздела 1.1.5.)


; SOLUTION:

(define (cdr z)
  (z (lambda (p q) q)))


; TESTS:

(define x (cons 2 3))

(check-equal? (car x) 2)
(check-equal? (cdr x) 3)
