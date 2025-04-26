;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDFQuiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Image, Image -> Bool
;; Input 2 images Output if first image is bigger true else false
(check-expect (bigger? (rectangle 3 2 "solid" "green") (rectangle 1 1 "solid" "red")) true)
(check-expect (bigger? (rectangle 1 2 "solid" "green") (rectangle 1 3 "solid" "red")) false)
(check-expect (bigger? (rectangle 1 1 "solid" "green") (rectangle 1 1 "solid" "red")) false)

;(define (bigger? img1 img2) false) ;Stub

;(define (bigger? img1 img2)
;( > (... img1) (... img2)))

(define (bigger? img1 img2)
( and (> (image-width img1) (image-width img2)) (> (image-height img1) (image-height img2))))