ECHO OFF
set CWD=%CD%
set FN=%1%
IF EXIST %FN% (
echo Start running dmu1
dmu1 < %1 > dmu1.lst
)
