@echo off
REM  ---------------------------------------------------------------------------------
REM  Copyright (c) Microsoft Open Technologies, Inc.  All rights reserved.
REM
REM The MIT License (MIT)
REM
REM Permission is hereby granted, free of charge, to any person obtaining a copy
REM of this software and associated documentation files (the "Software"), to deal
REM in the Software without restriction, including without limitation the rights
REM to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
REM copies of the Software, and to permit persons to whom the Software is
REM furnished to do so, subject to the following conditions:
REM
REM The above copyright notice and this permission notice shall be included in
REM all copies or substantial portions of the Software.
REM
REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
REM IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
REM FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
REM AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
REM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
REM THE SOFTWARE.
REM ---------------------------------------------------------------------------------
set puttydir="C:\program files (x86)\PuTTY\"
set prjdir=..\
set board_ip=xxx.xxx.xxx.xxx
set board_usr=root
set board_pw=
set CTD_Home=/root/node_app_slot
REM switch below lines if you have a password set for root user  
REM set PUTTY_CMD=%puttydir%putty %board_usr%@%board_ip% -pw %board_pw% 
set PUTTY_CMD=%puttydir%putty %board_usr%@%board_ip% 
REM switch below lines if you have a password set for root user  
REM set PSCP_CMD=%puttydir%pscp -pw %board_pw% 
set PSCP_CMD=%puttydir%pscp 

echo Creating destination folder on board...
del /f %TEMP%\boardconnectthedotsmacro.tmp
echo mkdir -p %CTD_Home% >> %TEMP%\boardconnectthedotsmacro.tmp
%PUTTY_CMD% -m %TEMP%\boardconnectthedotsmacro.tmp
 
echo Copying new project files
%PSCP_CMD% %prjdir%\..\Common\connectthedots.js %board_usr%@%board_ip%:%CTD_Home%/
%PSCP_CMD% %prjdir%\beagleboneblackctd.js %board_usr%@%board_ip%:%CTD_Home%/
%PSCP_CMD% %prjdir%\package.json %board_usr%@%board_ip%:%CTD_Home%/
%PSCP_CMD% %prjdir%\settings.json %board_usr%@%board_ip%:%CTD_Home%/

echo Installing/updating node modules
del /f %TEMP%\boardconnectthedotsmacro.tmp
echo cd %CTD_Home% >> %TEMP%\boardconnectthedotsmacro.tmp
echo npm install >> %TEMP%\boardconnectthedotsmacro.tmp
%PUTTY_CMD% -m %TEMP%\boardconnectthedotsmacro.tmp

