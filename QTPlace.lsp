;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:PLACE updates a vehicle at posicion 'C'
;
;
(defun QT:PLACE (C / ANG ENT ENTLIST NODE P)
 (foreach NODE QTVLIST
  (progn
   (setq ENT (last NODE))
   (setq ANG (nth C (cadr NODE)))
   (setq P (nth C (caddr NODE)))
   (setq ENTLIST (entget ENT))
   (setq ENTLIST (subst (append (list 10) P) (assoc 10 ENTLIST) ENTLIST))
   (setq ENTLIST (subst (cons 50 ANG) (assoc 50 ENTLIST) ENTLIST))
   (entmod ENTLIST)
   (entupd ENT)
  )
 )
)
