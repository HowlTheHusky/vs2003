IF NOT EXIST CS\BUILD.BAT GOTO CSEND
  CD CS
  CALL BUILD.BAT %1
  CD ..
:CSEND

IF NOT EXIST VB\BUILD.BAT GOTO VBEND
  CD VB
  CALL BUILD.BAT %1
  CD ..
:VBEND