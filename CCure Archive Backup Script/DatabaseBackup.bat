@ECHO off



REM	VARIABLE DEFINITION

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set currentdate=%%a-%%b-%%c)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set currenttime=%%a%%b)

set keepbackups=5



REM	BACKUP AND BACKUP LOG UPDATE

echo Updating Backup...

rem !!!
xcopy "C:\Users\drew0\Desktop\TestFolder" "I:\Backups\%currentdate%\%currenttime%\" /e /s /h /v

if %errorlevel% neq 0 (
	rem !!!
	echo Backup failed on %currentdate% at %currenttime% with errorlevel %errorlevel%.>>"I:\Logs\ErrorLog.txt"
	exit /b
)

rem !!!
echo Backup updated on %currentdate% at %currenttime%>>"I:\Logs\UpdateLog.txt"

echo Successfully updated backup on %currentdate% at %currenttime%.



REM	BACKUP DELETION AND DELETION LOG UPDATE

echo Checking Backup Days...

set "deletemessage="
for /f "skip=%keepbackups% delims=" %%a in (
	rem !!!
	'dir "I:\Backups\*" /t:c /a:d /o:-d /b'
) do (
	if not defined deletemessage (
		set deletemessage=1
		echo More than %keepbackups% backup days found - only the %MAXBACKUPS% most recent backup days will be preserved. See deletion logs for more information.
		rem !!!
		echo Backup folder for "%%a" deleted on %currentdate% at %currenttime%>>"I:\Logs\DeletionLog.txt"
	)
	rem !!!
	rd /s /q "I:\Backups\%%a"
)