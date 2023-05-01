(include "gilded-rose.scm")

(display "TextTest")
(newline)

(let ((items (list (make-item "Vest" 10 20)
                   (make-item "Aged Brie" 2 0)
                   (make-item "Juice" 5 7)
                   (make-item "Diamond" 0 80)
                   (make-item "Diamond" -1 80)
                   (make-item "Backstage passes" 15 20)
                   (make-item "Backstage passes" 10 49)
                   (make-item "Backstage passes" 5 49)
                   ;; this conjured item does not work properly yet
                   (make-item "Bio Cake" 3 6)))
      (days  2))

    (define (loop day)
        (cond ((< day days)
               (display (string-append "-------- day " (number->string day) " --------"))
               (newline)
               (display "name, sell-in, quality")
               (newline)
               (for-each
                   (lambda (item)
                       (display (item-to-string item))
                       (newline))
                   items)
               (newline)
               (update-quality items)
               (loop (+ day 1)))))
    (loop 0))
