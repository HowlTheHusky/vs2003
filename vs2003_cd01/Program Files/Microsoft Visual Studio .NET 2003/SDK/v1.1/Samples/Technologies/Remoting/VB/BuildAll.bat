IF NOT EXIST BASIC\BUILDALL.BAT GOTO BASICEND
  CD BASIC
  CALL BUILDALL.BAT
  CD ..
:BASICEND