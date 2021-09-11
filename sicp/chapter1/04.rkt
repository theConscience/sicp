#lang sicp

; TASK:

;Заметим, что наша модель вычислений разрешает существование комбинаций,
;операторы которых — составные выражения. С помощью этого наблюдения опишите,
;как работает следующая процедура:

(define ( a-plus-abs-b a b )
((if (> b 0) + -) a b))


; SOLUTION:
;
; If `b` param more then 0, then `+` operator applied to operands `a` and `b`
; If `b` param less or equal 0, then `-` operator applied to them
; So, 2nd line could be either:
; (+ a b)
; or no
; (- a b)
