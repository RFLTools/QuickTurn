;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:SETPATH Calculates the point list for a vehicle along a path
;
;
(defun QT:SETPATH (PLIST ENTFIRST / ANG ANGLIST C ENT ENT2 ENTLIST NODE P P0 P0LIST PD PH PHLIST TMP WF WR)
 (setq QTVLIST nil)
 (setq QTDLIST nil)
 (setq LBLIST nil)
 (setq LALIST nil)
 (setq ENT ENTFIRST)
 (while (and (/= nil PLIST) (/= nil ENT))
  (redraw ENT 2)
  (setq ENTLIST (entget ENT))
  (setq D0 nil DG nil D nil DH nil LA nil LB nil)
  (setq TMP (QT:GETD ENT))
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
  (if (and (/= nil D0) (/= nil DG) (/= nil D) (/= nil DH))
   (progn
    (setq ANG nil ANGLIST nil P0LIST nil PHLIST nil)
    (setq P (car PLIST))
    (setq ANG (cdr (assoc 50 ENTLIST)))
    (setq ANGLIST (list ANG))
    (setq P0 (list (- (car P) (* D0 (cos ANG)))
                   (- (cadr P) (* D0 (sin ANG)))))
    (setq P0LIST (list P0))
    (if (> DH 0.0)
     (progn
      (setq PH (list (+ (car P) (* (- DH D0) (cos ANG)))
                     (+ (cadr P) (* (- DH D0) (sin ANG)))))
      (setq PHLIST (list PH))
     )
    )
    (if (/= nil LB)
     (setq LBLIST (list (list (+ (car P) (* (- LB D0) (cos ANG)))
                              (+ (cadr P) (* (- LB D0) (sin ANG))))))
    )
    (if (/= nil LA)
     (setq LALIST (list (list (+ (car P) (* (- LA D0) (cos ANG)))
                              (+ (cadr P) (* (- LA D0) (sin ANG))))))
    )
    (setq C 1)
    (while (< C (length PLIST))
     (setq P (nth C PLIST))
     (setq ANG (QT:NEWANG ANG P (nth (- C 1) PLIST) D D0))
     (setq ANGLIST (append ANGLIST (list ANG)))
     (setq P0 (list (- (car P) (* D0 (cos ANG)))
                    (- (cadr P) (* D0 (sin ANG)))))
     (setq P0LIST (append P0LIST (list P0)))
     (if (> DH 0.0)
      (progn
       (setq PH (list (+ (car P) (* (- DH D0) (cos ANG)))
                      (+ (cadr P) (* (- DH D0) (sin ANG)))))
       (setq PHLIST (append PHLIST (list PH)))
      )
     )
     (if (/= nil LB)
      (progn
       (setq PLB (list (+ (car P) (* (- LB D0) (cos ANG)))
                       (+ (cadr P) (* (- LB D0) (sin ANG)))))
       (setq LBLIST (append LBLIST (list PLB)))
      )
     )
     (if (/= nil LA)
      (progn
       (setq PLA (list (+ (car P) (* (- LA D0) (cos ANG)))
                       (+ (cadr P) (* (- LA D0) (sin ANG)))))
       (setq LALIST (append LALIST (list PLA)))
      )
     )
     (setq C (+ C 1))
    )
    (setq ENT2 (QT:MAKETEMPBLOCK ENT))
    (redraw ENT2 2)
    (setq QTVLIST (append QTVLIST (list (list ENT ANGLIST P0LIST PHLIST ENT2))))
    (setq PLIST PHLIST)
   )
   (princ "\n!!! Problem retrieving vehicle data !!!")
  )
  (if (and (/= nil LBLIST) (/= nil LALIST))
   (progn
    (if (/= nil (setq ENT (car (entsel "\nSelect load vehicle (<return> for none) : "))))
     (progn
      (redraw ENT 2)
      (setq D0 nil DG nil D nil DH nil LA nil LB nil)
      (setq TMP (QT:GETD ENT))
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
      (if (and (/= nil LA) (/= nil LB))
       (progn
        (setq ANGLIST nil)
        (setq P0LIST nil)
        (setq C 0)
        (while (< C (length LBLIST))
         (if (< LA LB)
          (setq ANG (angle (nth C LALIST) (nth C LBLIST)))
          (setq ANG (angle (nth C LBLIST) (nth C LALIST)))
         )
         (setq ANGLIST (append ANGLIST (list ANG)))
         (setq P0 (list (- (car (nth C LBLIST)) (* LB (cos ANG)))
                        (- (cadr (nth C LBLIST)) (* LB (sin ANG)))))
         (setq P0LIST (append P0LIST (list P0)))
         (setq C (+ C 1))
        )
        (setq ENT2 (QT:MAKETEMPBLOCK ENT))
        (redraw ENT2 2)
        (setq QTVLIST (append QTVLIST (list (list ENT ANGLIST P0LIST nil ENT2))))
       )
      )
     )
    )
    (setq LBLIST nil)
    (setq LALIST nil)
   )
  )
  (if (= nil PLIST)
   (setq ENT nil)
   (setq ENT (car (entsel "\nSelect vehicle : ")))
  )
 )
 (foreach NODE QTVLIST (redraw (last NODE) 1))
)
