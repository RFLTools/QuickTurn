@echo off
rem
rem Simple copy batch to create combined lsp file
rem
if exist LoadQuickTurn.lsp del LoadQuickTurn.lsp
rem
COPY /B ".\QTGetD.lsp" + ^
        ".\QTWrapperStart.lsp" + ^
        ".\QTCircle3P.lsp" + ^
        ".\QTCopy.lsp" + ^
        ".\QTDrawEnvelope.lsp" + ^
        ".\QTDrawEnvelope2.lsp" + ^
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
        ".\RFLMakePL.lsp" + ^
        ".\QTWrapperEnd.lsp" + ^
        ".\QTMAke\QTMake.lsp" + ^
        ".\QTMAke\QTMakeDCL.lsp" + ^
        ".\QTMAke\QTMakeOUT.lsp" + ^
        ".\QTMAke\QTMakeSLB.lsp" + ^
        ".\QTMAke\QTAddCustom.lsp" + ^
        ".\QTMAke\QTWBlockListCustom.lsp" + ^
        ".\QTRMax.lsp" ^
        ".\LoadQuickTurn.lsp"
pause
