@ECHO OFF
schtasks /create /sc WEEKLY /tn "Task name" /d MON /tr "C:\PATH\script.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Task name" /d TUE /tr "C:\PATH\script.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Task name" /d WED /tr "C:\PATH\script.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Task name" /d THU /tr "C:\PATH\script.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Task name" /d FRI /tr "C:\PATH\script.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Task name" /d SAT /tr "C:\PATH\script.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Task name" /d SUN /tr "C:\PATH\script.bat" /st 16:00 /ru SYSTEM /rl HIGHEST &
schtasks /create /sc WEEKLY /tn "Task name" /d SUN /tr "C:\PATH\script.bat" /st 17:00 /ru SYSTEM /rl HIGHEST &

:start
SET choice=
SET /p choice=Create extra tasks? [Y/N]: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='Y' GOTO yes
IF '%choice%'=='y' GOTO yes
IF '%choice%'=='N' GOTO no
IF '%choice%'=='n' GOTO no
IF '%choice%'=='' GOTO no
ECHO "%choice%" is not valid
ECHO.
GOTO start

:no
ECHO Skipped creating extra Tasks...
PAUSE
EXIT

:yes
ECHO Creating extra Tasks...
schtasks /create /sc DAILY /tn "Task name" /tr "C:\PATH\script.bat" /st 23:00 /ru SYSTEM /rl HIGHEST &
schtasks /create /sc DAILY /tn "Task name" /tr "C:\PATH\script.bat" /st 23:30 /ru SYSTEM /rl HIGHEST &
schtasks /create /sc DAILY /tn "Task name" /tr "C:\PATH\script.bat" /st 23:45 /ru SYSTEM /rl HIGHEST &
PAUSE
EXIT
