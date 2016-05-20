@echo off
rem
rem Simple copy batch to create combined lsp file
rem
if exist LoadQuickTurn.lsp del LoadQuickTurn.lsp
rem
COPY ".\QTWrapperStart.lsp" + ^
     ".\QTCircle3P.lsp" + ^
     ".\QTCopy.lsp" + ^
     ".\QTDrawEnvelope.lsp" + ^
     ".\QTGetD.lsp" + ^
     ".\QTGetEnvelope.lsp" + ^
     ".\QTGetPList.lsp" + ^
     ".\QTGetTurnAng.lsp" + ^
     ".\QTMakeTempBlock.lsp" + ^
     ".\QTMoveVehicle.lsp" + ^
     ".\QTNewAng.lsp" + ^
     ".\QTNewWheelAng.lsp" + ^
     ".\QTPlace.lsp" + ^
     ".\QTSetPath.lsp" + ^
     ".\QTSetWheelAng.lsp" + ^
     ".\QTTPath.lsp" + ^
     ".\QTTWheels.lsp" + ^
     ".\QTMAke\QTMake.lsp" + ^
     ".\QTMAke\QTMakeDCL.lsp" + ^
     ".\QTMAke\QTMakeOUT.lsp" + ^
     ".\QTMAke\QTMakeSLB.lsp" + ^
     ".\QTWrapperEnd.lsp" ^
     ".\LoadQuickTurn.lsp"
pause
