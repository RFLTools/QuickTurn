;
;
;     Program written by Robert Livingston, 2015
;
;     QTSETWHEELANG updates the wheel angle of all the nested wheel blocks based on their position in a block to the turn angle of the block
;
;
(defun QT:SETWHEELANG (C QTVLIST PLIST / ANG DIRECTION NODE P0 P1 P2 PC R)
 (foreach NODE QTVLIST
  (if (or (= C CMAX) (= nil PLIST))
   (QT:NEWWHEELANG NODE 0.0)
   (progn
    (if (= C 0)
     (setq P0 nil P1 (nth C PLIST) P2 (nth (+ C 1) PLIST))
     (if (= C CMAX)
      (setq P0 (nth (- C 1) PLIST) P1 (nth C PLIST) P2 nil)
      (progn
       (setq P0 (nth (- C 1) PLIST) P1 (nth C PLIST) P2 (nth (+ C 1) PLIST))
       (setq PC (QT:CIRCLE3P P0 P1 P2))
       (if (= PC nil)
        (setq P0 nil)
        (progn
         (setq R (cadr PC))
         (setq PC (car PC))
         (setq ANG (angle P1 PC))
         (if (> (sin (- (angle P2 PC) (angle P1 PC))) 0.0)
          (setq ANG (- ANG (/ pi 2.0)))
          (setq ANG (+ ANG (/ pi 2.0)))
         )
         (setq P2 (list (+ (car P1) (* R (cos ANG)))
                        (+ (cadr P1) (* R (sin ANG)))))
        )
       )
      )
     )
    )	
    (setq ANG (nth C (cadr NODE)))
    (setq ANG (- ANG (angle P2 P1)))
    (while (< ANG 0.0)
     (setq ANG (+ ANG (* 2.0 pi)))
    )
    (while (>= ANG (* 2.0 pi))
     (setq ANG (- ANG (* 2.0 pi)))
    )
    (QT:NEWWHEELANG NODE (* -1.0 ANG))
    (setq PLIST (cadddr NODE))
   )
  )
 )
)
