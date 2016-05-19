;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:MOVEVEHICLE moves a vehicle to a position defined by grread
;
;
(defun QT:MOVEVEHICLE (PLIST / D P P0 PTMP)
 (setq D nil)
 (while (= 5 (car (setq P (grread T))))
  (setq P0 (cadr P))
  (setq D (apply 'min (mapcar '(lambda (PTMP) (distance P0 PTMP)) PLIST)))
  (setq C 0)
  (while (and (/= D (distance P0 (nth C PLIST)))
              (< C (length PLIST))
         )
   (setq C (1+ C))
  )
  (if (> C CMAX) (setq C CMAX))
  (QT:PLACE C)
  (QT:SETWHEELANG C QTVLIST PLIST)
 )
)
