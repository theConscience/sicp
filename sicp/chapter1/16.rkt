#lang sicp

(#%require rackunit)

; TASK:
;
; Быстрое возведение в степень
; Напишите процедуру solution , которая развивается в виде итеративного
; процесса и реализует возведение в степень за логарифмическое число шагов, как
; fast-expt (Указание: используя наблюдение, что (bⁿ୵²)² = (b²)ⁿ୵² , храните,
; помимо значения степени n и основания b , дополнительную переменную состояния
; a , и определите переход между состояниями так, чтобы произведение abⁿ от
; шага к шагу не менялось. Вначале значение a берется равным 1, а ответ
; получается как значение a в момент окончания процесса. В общем случае метод
; определения инварианта (invariant quantity), который не изменяется при
; переходе между шагами, является мощным способом размышления о построении
; итеративных алгоритмов.)


; SOLUTION:

(define (solution base degree)

  (define (s-iter b n a)
    (cond
      ((< n 0) (/ 1 (s-iter b (- n) a)))
      ((= n 0) (if (= a 1) 1 a))
      ((even? n) (s-iter (* b b) (/ n 2) a))
      (else (s-iter b (- n 1) (* a b)))))

  (s-iter base degree 1))



; INTERPRETING:

; (solution 2 2)
; (s-iter 2 2 1)
; (s-iter 2 1 2)
; (2 * 2)

; (solution 2 3)
; (s-iter 2 3 1)
; (s-iter 2 2 2)
; (s-iter 2 1 4)
; (2 * 4)

; (solution 2 4)
; (s-iter 2 4 1)
; (s-iter 2 2 4)
; (s-iter 2 1 8)
; (2 * 8)

; (solution 2 5)
; (s-iter 2 5 1)
; (s-iter 2 4 2)
; (s-iter 2 2 8)
; (s-iter 2 1 16)
; (2 * 16)

; (solution 2 6)
; (s-iter 2 6 1)
; (s-iter 2 3 8)
; (s-iter 2 2 16)
; (s-iter 2 1 32)
; (2 * 32)

; (solution 2 6)
; (s-iter 2 6 1)
; (s-iter 4 3 1)
; (s-iter 4 2 4)
; (s-iter 8 1 4)
; (s-iter 8 0 32)

; (solution 2 8)
; (s-iter 2 8 1)
; (s-iter 2 4 16)

; (solution 2 10)
; (s-iter 2 10 1)
; (s-iter 2 5 32)

; TESTS:

(check-equal? (solution 0 0) 1)
(check-equal? (solution 0 1) 0)
(check-equal? (solution 0 10) 0)
(check-equal? (solution 1 0) 1)
(check-equal? (solution 2 0) 1)
(check-equal? (solution 10 0) 1)
(check-equal? (solution 2 2) 4)
(check-equal? (solution 2 3) 8)
(check-equal? (solution 2 4) 16)
(check-equal? (solution 2 5) 32)
(check-equal? (solution 2 6) 64)
(check-equal? (solution 2 7) 128)
(check-equal? (solution 2 8) 256)
(check-equal? (solution 2 9) 512)
(check-equal? (solution 2 10) 1024)
(check-equal? (solution 3 1) 3)
(check-equal? (solution 3 2) 9)
(check-equal? (solution 3 3) 27)
(check-equal? (solution 3 4) 81)
(check-equal? (solution 10 -1) 1/10)
(check-equal? (solution 2 -3) 1/8)
