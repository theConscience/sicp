#lang sicp

(#%require rackunit)

; TASK:
;
; Золотое сечение
;
; Покажите, что золотое сечение φ (раздел 1.2.2) есть неподвижная точка
; трансформации x → 1 + 1/x , и используйте этот факт для вычисления
; φ с помощью процедуры fixed-point .

(define (fixed-point f first-guess)
  (define tolerance 0.0000000001)
  (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))

  (try first-guess))



; SOLUTION:

; Формула золотого сечения:
; φ^2 = φ + 1
;
; Поделим обе части на φ:
; φ = 1 + 1/φ
;
; ЧТД:   x -> 1 + 1/x

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)


