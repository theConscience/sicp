#lang racket  ; an echo server

(define (factorial n)
  (if (= n 1)
      n
      (* n (factorial (- n 1)))))

(factorial 4)
