#lang sicp

(#%require rackunit)

; TASK:
;
; Упражнение 2.6.
;
; Если представление пар как процедур было для Вас еще недостаточно
; сумасшедшим, то заметьте,
; что в языке, который способен манипулировать процедурами, мы можем обойтись
; и без чисел (по
; крайней мере, пока речь идет о неотрицательных числах), определив
; 0 и операцию прибавления 1
; так:

(define zero
  (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; Такое представление известно как числа Чёрча (Church numerals), по имени его
; изобретателя, Алонсо Чёрча, того самого логика, который придумал λ-исчисление.
; Определите one (единицу) и two (двойку) напрямую (не через zero и add-1).
; (Подсказка: вычислите (add-1 zero) с помощью подстановки.)
; Дайте прямое определение процедуры сложения + (не в терминах повторяющегося применения add-1).


; SOLUTION:

(add-1 zero)
;
; ; Вычисляем с помощью подстановки:
;
; (lambda (f)
;   (lambda (x) (f ((zero f) x))))
;
; (lambda (f)
;   (lambda (x) (f (((lambda (f) (lambda (y) y)) f) x))))
;
; (lambda (f)
;   (lambda (x) (f ((lambda (y) y) x))))
;
; (lambda (f)
;   (lambda (x) (f x)))


; One:

(define one (lambda (f) (lambda (x) (f x))))

(add-1 one)

; (lambda (f)
;   (lambda (x) (f ((one f) x))))
;
; (lambda (f)
;   (lambda (x) (f (((lambda (f2) (lambda (y) (f2 y))) f) x))))
;
; (lambda (f)
;   (lambda (x) (f ((lambda (y) (f y)) x))))
;
; (lambda (f)
;   (lambda (x) (f (f x))))


; Two:

(define two (lambda (f) (lambda (x) (f (f x)))))

(add-1 two)

; (lambda (f)
;   (lambda (x) (f ((two f) x))))
;
; (lambda (f)
;   (lambda (x) (f (((lambda (f2) (lambda (y) (f2 (f2 y)))) f) x))))
;
; (lambda (f)
;   (lambda (x) (f (((lambda (y) (f (f y))) x))))
;
; (lambda (f)
;   (lambda (x) (f (f (f x))))


; Addition:

(define (add n m)
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))

(add one two)

; (lambda (f) (lambda (x) ((one f) ((two f) x))))

; (lambda (f) (lambda (x)
;   (((lambda (n) (lambda (y) (n y))) f)
;   ((two f) x))))

; (lambda (f) (lambda (x)
;   (((lambda (n) (lambda (y) (n y))) f)
;   (((lambda (m) (lambda (z) (m (m z)))) f) x))))

; (lambda (f) (lambda (x)
;   ((lambda (y) (f y))
;   ((lambda (z) (f (f z))) x))))

; (lambda (f) (lambda (x)
;   ((lambda (y) (f y))
;   (f (f x)))))

; (lambda (f) (lambda (x)
;   ((lambda (y) (f y)) (f (f x)))))

; (lambda (f) (lambda (x)
;   (f (f (f x)))))

; (lambda (f) (lambda (x) (f (f (f x)))))


; Multiplication:

; (define mul (lambda (f g) (f g)))

; (lambda (one two) (one two))
;
; (lambda (f) (lambda (x) (f x))) two)
;
; (lambda (f) (lambda (x) (f x))) (lambda (f2) (lambda (y) (f2 (f2 y)))))
;
; (lambda (x) ((lambda (f2) (lambda (y) (f2 (f2 y)))) x))
;
; (lambda (x) (lambda (y) (x (x y))))

; (define mul (lambda (f g) (lambda (x) (f (g x)))))

; (lambda (one two) (lambda (x) (one (two x))))
;
; (lambda (x) ((lambda (f) (lambda (y) (f y))) (two x)))
;
; (lambda (x) ((lambda (f) (lambda (y) (f y))) ((lambda (g) (lambda (z) (g (g z)))) x)))
;
; (lambda (x) ((lambda (f) (lambda (y) (f y))) (lambda (z) (x (x z)))))
;
; (lambda (x) (lambda (y) ((lambda (z) (x (x z))) y)))
;
; (lambda (x) (lambda (y) (x (x y))))

(define (mul n m)
  (lambda (f) (lambda (x) ((n (m f)) x))))

(mul one two)


; HELPERS:

(define (church->nat n) ((n inc) 0))

(define (inc x) (+ x 1))


; TESTS:

(check-equal? (church->nat zero) 0)
(check-equal? (church->nat one) 1)
(check-equal? (church->nat two) 2)
(check-equal? (church->nat (add one one)) 2)
(check-equal? (church->nat (add two one)) 3)
(check-equal? (church->nat (add (add two one) zero)) 3)
(check-equal? (church->nat (add (add two one) one)) 4)
(check-equal? (church->nat (mul one one)) 1)
(check-equal? (church->nat (mul two one)) 2)
(check-equal? (church->nat (mul (mul two one) zero)) 0)
(check-equal? (church->nat (mul (mul two one) one)) 2)
(check-equal? (church->nat (mul (mul two two) two)) 8)
