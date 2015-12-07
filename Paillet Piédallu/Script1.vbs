option explicit
WGMgr.DeleteAll
InputPlaneMgr.DeleteAll

' Paramètres
Dim EspacementLignes, LongueurLignes
EspacementLignes    = 5
LongueurLignes      = 650

Dim LongueurS, LargeurS
LongueurS   = 400
LargeurS    = 5

Dim LineWidth
LineWidth = "2"

Dim LinearTop, LinearBot, SBendArcTopI, SBendArcTopO, SBendArcBotI, SBendArcBotO


Set LinearTop = WGMgr.CreateObj ( "WGLinear", "LinearTop" )
Set LinearBot = WGMgr.CreateObj ( "WGLinear", "LinearBot" )
Set SBendArcTopI = WGMgr.CreateObj ( "WGSBendArc", "SBendArcTopI" )
Set SBendArcTopO = WGMgr.CreateObj ( "WGSBendArc", "SBendArcTopO" )
Set SBendArcBotI = WGMgr.CreateObj ( "WGSBendArc", "SBendArcBotI" )
Set SBendArcBotO = WGMgr.CreateObj ( "WGSBendArc", "SBendArcBotO" )

LinearTop.SetProfileName       "guidecanal1"
LinearBot.SetProfileName       "guidecanal1"
SBendArcTopI.SetProfileName    "guidecanal1"
SBendArcTopO.SetProfileName    "guidecanal1"
SBendArcBotI.SetProfileName    "guidecanal1"
SBendArcBotO.SetProfileName    "guidecanal1"

LinearTop.SetDefaultThicknessTaperMode     True
LinearBot.SetDefaultThicknessTaperMode     True
SBendArcTopI.SetDefaultThicknessTaperMode  True
SBendArcTopO.SetDefaultThicknessTaperMode  True
SBendArcBotI.SetDefaultThicknessTaperMode  True
SBendArcBotO.SetDefaultThicknessTaperMode  True

LinearTop.SetAttr      "WidthExpr", cstr(LineWidth)
LinearBot.SetAttr      "WidthExpr", cstr(LineWidth)
SBendArcTopI.SetAttr   "WidthExpr", cstr(LineWidth)
SBendArcTopO.SetAttr   "WidthExpr", cstr(LineWidth)
SBendArcBotI.SetAttr   "WidthExpr", cstr(LineWidth)
SBendArcBotO.SetAttr   "WidthExpr", cstr(LineWidth)

Dim InputPlane1
Set InputPlane1 = InputPlaneMgr.CreateObj ( "Gaussian", "InputPlane1" )
InputPlane1.SetZPosition 0
InputPlane1.SetReferenceIndexWaveguide2D "Unknown"
InputPlane1.SetReferenceIndexWaveguide3D "Unknown"
Dim InputFieldGauss1
Set InputFieldGauss1 = InputPlane1.CreateInputField ("2D", "Gaussian", "InputFieldGauss1")
InputFieldGauss1.SetWaveguideID "SBendArcTopI"
InputFieldGauss1.SetAmplitude "1.0"
InputFieldGauss1.SetPhase "0.0"
InputFieldGauss1.SetTiltAngleType "User"
InputFieldGauss1.SetTiltAngle "0.0"
InputFieldGauss1.SetTiltIndexType "User"
InputFieldGauss1.SetTiltIndex "0.0"
InputFieldGauss1.SetWidthTypeX "User"
InputFieldGauss1.SetWidthX "1.0"
InputFieldGauss1.SetWidthTypeY "User"
InputFieldGauss1.SetWidthY "0.0"
InputPlane1.SetEnabled TRUE



Dim lambda

' Start Simulation
Dim x
For x = 1 to 10
    LinearTop.SetPosition       LongueurS,                  EspacementLignes/2,             LongueurS + LongueurLignes, EspacementLignes/2
    LinearBot.SetPosition       LongueurS,                 -EspacementLignes/2,             LongueurS + LongueurLignes,-EspacementLignes/2

    SBendArcTopI.SetPosition    0,                          EspacementLignes/2 + LargeurS,  LongueurS,                  EspacementLignes/2
    SBendArcTopO.SetPosition    LongueurS + LongueurLignes, EspacementLignes/2,           2*LongueurS + LongueurLignes, EspacementLignes/2 + LargeurS

    SBendArcBotI.SetPosition    0,                         -EspacementLignes/2 - LargeurS,  LongueurS,                 -EspacementLignes/2
    SBendArcBotO.SetPosition    LongueurS + LongueurLignes,-EspacementLignes/2,           2*LongueurS + LongueurLignes,-EspacementLignes/2 - LargeurS

    ParamMgr.SetParam"lambda", CStr(1.31)
    ParamMgr.Simulate
    ParamMgr.SetParam"lambda", CStr(1.55)
    ParamMgr.Simulate

    LongueurLignes=LongueurLignes+15
Next
