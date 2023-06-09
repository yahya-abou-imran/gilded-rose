;; Hi and welcome to team Gilded Rose. As you know, we are a small inn
;; with a prime location in a prominent city ran by a friendly
;; innkeeper named Allison. We also buy and sell only the finest goods.
;; Unfortunately, our goods are constantly degrading in quality as they
;; approach their sell by date. We have a system in place that updates
;; our inventory for us. It was developed by a no-nonsense type named
;; Leeroy, who has moved on to new adventures. Your task is to add the
;; new feature to our system so that we can begin selling a new
;; category of items.

;; First an introduction to our system:
;; All items have a SellIn value which denotes the number of days we have to sell the item
;; All items have a Quality value which denotes how valuable the item is
;; At the end of each day our system lowers both values for every item
;; Pretty simple, right? Well this is where it gets interesting:
;; Once the sell by date has passed, Quality degrades twice as fast
;; The Quality of an item is never negative
;; "Aged Brie" actually increases in Quality the older it gets
;; The Quality of an item is never more than 50
;; "Diamond", being a legendary item, never has to be sold or decreases in Quality
;; "Backstage passes", like aged brie, increases in Quality as it's
;;   SellIn value approaches; Quality increases by 2 when there are 10
;;   days or less and by 3 when there are 5 days or less but Quality
;;   drops to 0 after the concert

;; We have recently signed a supplier of conjured items. This requires an update to our system:
;; "Bio" items degrade in Quality twice as fast as normal items
;; Feel free to make any changes to the UpdateQuality method and add
;; any new code as long as everything still works correctly. However,
;; do not alter the Item class or Items property as those belong to the
;; goblin in the corner who will insta-rage and one-shot you as he
;; doesn't believe in shared code ownership (you can make the
;; UpdateQuality method and Items property static if you like, we'll
;; cover for you).
;; Just for clarification, an item can never have its Quality increase
;; above 50, however "Diamond" is a legendary item and as such its
;; Quality is 80 and it never alters.

;; https://github.com/emilybache/GildedRose-Refactoring-Kata

;; Common Lisp functional version: Manfred Bergmann, 2022

;;; ================================================================
;;; Code

(defpackage :gilded-rose
  (:use :cl))

(in-package :gilded-rose)


;;; Class ITEM

(defstruct item
  (name "" :type string :read-only t)
  (sell-in 0 :type integer)
  (quality 0 :type integer))

(defun update-quality (items)
  (mapcar #'update-item items))

(defun update-item (item)
  (let ((new-item (copy-structure item)))
    (with-slots (name quality sell-in) new-item
      (if (and (not (equalp name "Aged Brie"))
               (not (equalp name "Backstage passes")))
          (if (> quality 0)
              (if (not (equalp name "Diamond"))
                  (setf quality (- quality 1))))
          (when (< quality 50)
            (setf quality (+ quality 1))
            (when (equalp name "Backstage passes")
              (if (< sell-in 11)
                  (if (< quality 50)
                      (setf quality (+ quality 1))))
              (if (< sell-in 6)
                  (if (< quality 50)
                      (setf quality (+ quality 1)))))))

      (if (not (equalp name "Diamond"))
          (setf sell-in (- sell-in 1)))

      (if (< sell-in 0)
          (if (not (equalp name "Aged Brie"))
              (if (not (equalp name "Backstage passes"))
                  (if (> quality 0)
                      (if (not (equalp name "Diamond"))
                          (setf quality (- quality 1))))
                  (setf quality (- quality quality)))
              (if (< quality 50)
                  (setf quality (+ quality 1))))))
    new-item))

;;; Example

(defun to-string (item)
  (with-slots (name quality sell-in) item
    (format nil "~a, ~a, ~a" name sell-in quality)))

(defun print-day (day items)
  (format t "-------- day ~a --------~%" day)
  (format t "name, sell-in, quality~%")
  (dolist (item items)
    (write-line (to-string item)))
  (terpri))

(defun run-gilded-rose (days)
  (write-line "TextTest")
  (let* ((descriptions '(("Vest"                         10 20)
                         ("Aged Brie"                                  2  0)
                         ("Juice"                     5  7)
                         ("Diamond"                 0 80)
                         ("Diamond"                -1 80)
                         ("Backstage passes" 15 20)
                         ("Backstage passes" 10 49)
                         ("Backstage passes"  5 49)
                         ;; this conjured item does not work properly yet
                         ("Bio Cake"                         3  6)))
         (items (loop :for (name sell-in quality) :in descriptions
                      :collect (make-item :name name
                                          :sell-in sell-in
                                          :quality quality))))
    (loop :for day :upto days
          :with the-items = items
          :do (progn
                (print-day day the-items)
                (setf the-items (update-quality the-items))))))

;;; ================================================================
