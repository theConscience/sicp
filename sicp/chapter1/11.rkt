#lang sicp

(#%require rackunit)

; TASK:
;
; Итеративные и рекурсивные процессы
; Функция f определяется правилом: f(n) = n , если n < 3 ,
; и f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) , если n ≥ 3 .
; Напишите процедуру f , вычисляющую f с помощью рекурсивного процесса.
; Напишите процедуру f-iter , вычисляющую f с помощью итеративного процесса.


; SOLUTION:

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))
      ))

(define (f-iter max-count)

  (define (f-iterator x y z counter)
    (if (> counter max-count)
        x
        (f-iterator
          (if (< counter 3)
              counter
              (+ x (* 2 y) (* 3 z)))
          x
          y
          (+ counter 1))
        ))

  (f-iterator 0 0 0 0))


; TESTS:

(check-equal? (f 5) 25)
(check-equal? (f-iter 4) 11)
(check-equal? (f 3) 4)
(check-equal? (f-iter 1) 1)
