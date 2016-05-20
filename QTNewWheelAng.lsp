;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:NEWWHEELANG Updates the wheel angle for NODE
;
;
(defun QT:NEWWHEELANG (NODE ANG / A ANG2 D D0 DG DH ENT ENT2 ENT3 ENTLIST LOCKANG P SCALE TAN TMP TOL WF WR X Y)
 (setq TOL 0.000001)
 (defun TAN (ANG)
  (/ (sin ANG) (cos ANG))
 )
 (setq ENT (last NODE))
 (setq ENTLIST (entget ENT))
 (if (= "INSERT" (cdr (assoc 0 ENTLIST)))
  (progn
   (setq SCALE (cdr (assoc 41 ENTLIST)))
   (setq ENTLIST (tblsearch "BLOCK" (cdr (assoc 2 ENTLIST))))
   (setq ENT2 (cdr (assoc -2 ENTLIST)))
   (while (/= nil ENT2)
    (setq ENTLIST (entget ENT2))
    (if (= "INSERT" (cdr (assoc 0 ENTLIST)))
     (progn
      (if (< (abs ANG) TOL)
       (setq ANG2 ANG)
       (progn
        (setq P (cdr (assoc 10 ENTLIST)))
        (setq X (* (car P) SCALE))
        (setq Y (* (cadr P) SCALE))
        (setq TMP (QT:GETD (car NODE)))
        (setq D0 (nth 0 TMP)
              DG (nth 1 TMP)
              D (nth 2 TMP)
              DH (nth 3 TMP)
              LOCKANG (nth 4 TMP)
              LB (nth 5 TMP)
              LA (nth 6 TMP)
              WF (nth 7 TMP)
              WR (nth 8 TMP)
        )
        (setq A (/ (- D D0) (TAN ANG)))
        (setq ANG2 (atan (/ (- D X) (+ A Y))))
       )
      )
      (setq ENTLIST (subst (cons 50 ANG2) (assoc 50 ENTLIST) ENTLIST))
      (entmod ENTLIST)
      (entupd ENT)
     )
    )
    (setq ENT2 (entnext ENT2))
   )
  )
 )
)
