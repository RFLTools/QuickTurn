@echo off
rem
rem Simple copy batch to create combined lsp file
rem
if exist LoadQuickTurn.lsp del LoadQuickTurn.lsp
rem
COPY ".\QTCopy.lsp" + ^
     ".\QTGetD.lsp" + ^
     ".\QTGetPList.lsp" + ^
     ".\QTMakeTempBlock.lsp" + ^
     ".\QTMoveVehicle.lsp" + ^
     ".\QTPlace.lsp" + ^
     ".\QTSetWheelAng.lsp" + ^
     ".\QTTPATH.lsp" + ^
     ".\QTTWheels.lsp" + ^
     ".\QTMAke\QTMake.lsp" + ^
     ".\QTMAke\QTMakeOUT.lsp" + ^
     ".\QTMAke\QTMakeSLB.lsp" ^
     ".\LoadQuickTurn.lsp"
pause
