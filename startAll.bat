@echo off

set apk="D:\apks\test.apk"

::cd "C:\Program Files (x86)\Android\android-sdk\build-tools\26.0.1\"

call :getPackagename package
call :getMainClass mainClass

call :Header

"C:\Android\platform-tools\adb" disconnect

set hour=%time:~0,2%
if %hour% lss 12 set hour=0%hour:~1,1%
set min=%time:~3,2%
set sec=%time:~6,2%

set filename=%hour%-%min%-%sec%
set location="D:\logs\%filename% - %package%.txt"

SET /A ip=61
SET name=Samsung S7
call :ConnectDevice

SET /A ip=171
SET name=Samsung J3
call :ConnectDevice

SET /A ip=63
SET name=Samsung S5
call :ConnectDevice

SET /A ip=130
SET name=Samsung Tablet
call :ConnectDevice

call :Connect

pause
exit

:Connect
FOR /F "skip=1" %%x IN ('adb devices') DO START "startSingle" /D "D:\mendixhub\Reaper-DeviceLab" startSingle %%x %apk% %package%
GOTO:EOF

:ConnectDevice
echo [45;93m Connecting to 129.168.177.%ip% - %name%[0m
@echo Connecting to 129.168.177.%ip% - %name% >> %location%
adb connect 192.168.177.%ip% | find /i "connected to"
GOTO:EOF

:DrawLine
echo [30;30m [0m
echo [92m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~[0m
echo [30;30m [0m
GOTO:EOF

:Header
set line1=%line1%       [102;102m   [0m          [41;41m                                       [0m
set line2=%line2%        [102;102m [0m           [41;41m [0m[101;101m [0m[30;30m    [0m[101;101m [0m[101;101m [0m[30;30m     [0m[101;101m   [0m[30;30m [0m[101;101m  [0m[101;101m [0m[30;30m    [0m[101;101m [0m[101;101m [0m[30;30m     [0m[101;101m [0m[30;30m    [0m[101;101m  [0m[41;41m [0m
set line3=%line3%    [102;102m [0m       [102;102m [0m       [41;41m [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [0m[101;101m [0m[30;30m [0m[101;101m    [0m[101;101m  [0m[30;30m [0m[101;101m [0m[30;30m [101;101m [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [0m[101;101m [0m[30;30m [0m[101;101m    [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [0m[101;101m [0m[41;41m [0m
set line4=%line4%    [102;102m  [0m  [101;101m [0m  [102;102m  [0m       [41;41m [0m[101;101m [0m[30;30m    [0m[101;101m [0m[101;101m [0m[30;30m     [0m[101;101m [0m[30;30m     [0m[101;101m [0m[30;30m    [0m[101;101m [0m[101;101m [0m[30;30m     [0m[101;101m [0m[30;30m    [0m[101;101m  [0m[41;41m [0m
set line5=%line5%    [102;102m [0m       [102;102m [0m       [41;41m [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [0m[101;101m [0m[30;30m [0m[101;101m    [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [101;101m [0m[30;30m [0m[101;101m    [0m[101;101m [0m[30;30m [0m[101;101m    [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [0m[101;101m [0m[41;41m [0m
set line6=%line6%        [102;102m [0m           [41;41m [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [0m[101;101m [0m[30;30m     [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [101;101m [0m[30;30m [0m[101;101m    [0m[101;101m [0m[30;30m     [0m[101;101m [0m[30;30m [0m[101;101m   [0m[30;30m [0m[101;101m [0m[41;41m [0m
set line7=%line7%       [102;102m   [0m          [41;41m                                       [0m

set line2=%line2%        [92mIncentro BA Testlab[0m
set line3=%line3%          [92mAndroid devices[0m
set line4=%line4%                 [92m-[0m
set line5=%line5%            [92mDennis Reep[0m
set line6=%line6%     [92mVersion 1.0 - 31/01/2018[0m
 
call :DrawLine
echo %line1%
echo %line2% 
echo %line3% 
echo %line4% 
echo %line5% 
echo %line6% 
echo %line7% 
call :DrawLine
GOTO:EOF

:getMainClass
setlocal enableextensions enabledelayedexpansion
for /f "delims=" %%i in ('aapt dump badging %apk%') do (
	SET name=%%i
	if not "!name:launchable-activity=!"=="!name!" (
		:loopLine
		set /a num=num+1
		call set "name2=%%name:~%num%,1%%"
		if defined name2 (

		if "%name2%"=="'" (
			if "%write%"=="true" (
				endlocal & set %1=%output%
				goto:EOF
			) else (
				set write=true
			)
		)
		if not "%end%"=="yes" (
			if "%write%"=="true" (
				set output=%output%%name2%
			)
			goto :loopLine
		)
		)
	)
)
endlocal
goto:EOF

:getPackagename
setlocal enableextensions enabledelayedexpansion
for /f "delims=" %%i in ('aapt dump badging %apk%') do (
	SET name=%%i
	
	:loopLine
	set /a num=num+1
	call set "name2=%%name:~%num%,1%%"
	if defined name2 (

	if "%name2%"=="'" (
		if "%write%"=="true" (
			endlocal & set %1=%output%
			goto:EOF
		) else (
			set write=true
		)
	)
	if not "%end%"=="yes" (
		if "%write%"=="true" (
			set output=%output%%name2%
		)
		goto :loopLine
	)
	)
)
goto:EOF