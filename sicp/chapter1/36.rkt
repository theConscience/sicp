#lang sicp

(#%require rackunit)

; TASK:
;
; Поиск неподвижной точки
;
; Измените процедуру fixed-point так, чтобы она печатала последовательность
; приближений, которые порождает, с помощью примитивов newline и display
; , показанных в упражнении 1.22 .
; Затем найдите решение уравнения x^x = 1000 путем поиска неподвижной точки
; x → log(1000)/log(x) .
; (Используйте встроенную процедуру Scheme log , которая вычисляет
; натуральные логарифмы.)
; Посчитайте, сколько шагов это занимает при использовании торможения
; усреднением и без него.
; (Учтите, что нельзя начинать fixed-point со значения 1, поскольку это
; вызовет деление на log(1) = 0 .)

(define (fixed-point f first-guess)
  (define tolerance 0.000001)
  (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))

  (try first-guess))


; SOLUTION:

(define (fixed-point f first-guess)
  (define tolerance 0.000001)
  (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))

  (try first-guess))

#| (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0) |#

(fixed-point (lambda (x) (/ (log 1000) (log x))) 1.1)
