ECHO OFF
set CWD=%CD%
set FN=%1%
IF EXIST %FN% (
echo Start running dmuai
dmuai < %1 > dmuai.lst
)
