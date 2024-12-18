:: AUTHOR: HAYDEN HILDRETH
:: DATE: 12/18/2024
:: SCRIPT VERSION: 0.4
:: PURPOSE: CUT DOWN ON TIME SETTING UP TASKS AND DOING MANUAL WORK, I.E. CREATING FOLDERS 1-7, COPY BATCH FILES, ETC...
:: NOTES: MUST BE RAN AS ADMIN TO EXECUTE schtasks COMMAND.

:: CREATE MAIN FOLDER CCGH IF DNE
if not exist "C:\PATH\" mkdir C:\PATH\

:: CREATE BACKUP FOLDER, AND BACKUP SUBFOLDERS IF DO NOT EXIST
if not exist "C:\PATH\BACKUP\" mkdir C:\CCGH\BACKUP\
if not exist "C:\PATH\BACKUP\1" mkdir C:\CCGH\BACKUP\1
if not exist "C:\PATH\BACKUP\2" mkdir C:\CCGH\BACKUP\2
if not exist "C:\PATH\BACKUP\3" mkdir C:\CCGH\BACKUP\3
if not exist "C:\PATH\BACKUP\4" mkdir C:\CCGH\BACKUP\4
if not exist "C:\PATH\BACKUP\5" mkdir C:\CCGH\BACKUP\5
if not exist "C:\PATH\BACKUP\6" mkdir C:\CCGH\BACKUP\6
if not exist "C:\PATH\BACKUP\7" mkdir C:\CCGH\BACKUP\7

:: CREATE BACKUP BATCH FILES IF DO NOT EXIST, THIS WRITES THE BATCH FILE SO YOU DO NOT NEED TO TRANSFER
if not exist "C:\PATH\BACKUP\Backup_1.bat" echo."C:\Program Files (x86)\PATH\PATH\BIN\EXECUTABLE.exe" /q /o C:\PATH\backup\1>C:\PATH\BACKUP\Backup_1.bat
if not exist "C:\PATH\BACKUP\Backup_2.bat" echo."C:\Program Files (x86)\PATH\PATH\BIN\EXECUTABLE.exe" /q /o C:\PATH\backup\2>C:\PATH\BACKUP\Backup_2.bat
if not exist "C:\PATH\BACKUP\Backup_3.bat" echo."C:\Program Files (x86)\PATH\PATH\BIN\EXECUTABLE.exe" /q /o C:\PATH\backup\3>C:\PATH\BACKUP\Backup_3.bat
if not exist "C:\PATH\BACKUP\Backup_4.bat" echo."C:\Program Files (x86)\PATH\PATH\BIN\EXECUTABLE.exe" /q /o C:\PATH\backup\4>C:\PATH\BACKUP\Backup_4.bat
if not exist "C:\PATH\BACKUP\Backup_5.bat" echo."C:\Program Files (x86)\PATH\PATH\BIN\EXECUTABLE.exe" /q /o C:\PATH\backup\5>C:\PATH\BACKUP\Backup_5.bat
if not exist "C:\PATH\BACKUP\Backup_6.bat" echo."C:\Program Files (x86)\PATH\PATH\BIN\EXECUTABLE.exe" /q /o C:\PATH\backup\6>C:\PATH\BACKUP\Backup_6.bat
if not exist "C:\PATH\BACKUP\Backup_7.bat" echo."C:\Program Files (x86)\PATH\PATH\BIN\EXECUTABLE.exe" /q /o C:\PATH\backup\7>C:\PATH\BACKUP\Backup_7.bat

:: CREATE SCHEDULED TASKS FOR EVERYDAY, ALSO CREATE SUNDAY REBOOT TASK
schtasks /create /sc WEEKLY /tn "Backups\1.Monday Backup" /d MON /tr "C:\CCGH\BACKUP\Backup_1.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Backups\2.Tuesday Backup" /d TUE /tr "C:\CCGH\BACKUP\Backup_2.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Backups\3.Wednesday Backup" /d WED /tr "C:\CCGH\BACKUP\Backup_3.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Backups\4.Thursday Backup" /d THU /tr "C:\CCGH\BACKUP\Backup_4.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Backups\5.Friday Backup" /d FRI /tr "C:\CCGH\BACKUP\Backup_5.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Backups\6.Saturday Backup" /d SAT /tr "C:\CCGH\BACKUP\Backup_6.bat" /st 23:00 /ru SYSTEM /rl HIGHEST & 
schtasks /create /sc WEEKLY /tn "Backups\7.Sunday Backup" /d SUN /tr "C:\CCGH\BACKUP\Backup_7.bat" /st 16:00 /ru SYSTEM /rl HIGHEST &
schtasks /create /sc WEEKLY /tn "Backups\Sunday Server Reboot" /d SUN /tr "shutdown /r" /st 17:00 /ru SYSTEM /rl HIGHEST &

:: ASK IF  WANT TO CREATE GPS TASKS
:start
SET choice=
SET /p choice=Create GPS tasks? [Y/N]: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='Y' GOTO yes
IF '%choice%'=='y' GOTO yes
IF '%choice%'=='N' GOTO no
IF '%choice%'=='n' GOTO no
IF '%choice%'=='' GOTO no
ECHO "%choice%" is not valid
ECHO.
GOTO start

:: IF NO SKIP GPS TASKS
:no
ECHO Skipped creating GPS Tasks...
PAUSE
EXIT

:: IF YES CREATE GPS TASKS
:: AND CREATE GPS FILES + FOLDERS
:yes
ECHO Creating GPS Tasks...
if not exist "C:\PATH\BACKUP\GPSDB\BACKUP\DB" mkdir C:\PATH\BACKUP\GPSDB\BACKUP\DB
if not exist "C:\PATH\BACKUP\GPSDB\BACKUP\SQLBK-DB.bat" echo.'sqlcmd -S .\GPS -Usa -Ppassword -Q "EXEC sp_BackupDatabases @backupLocation='C:\PATH\Backup\GPSDB\BACKUP\DB\', @backupType='F'"'
if not exist "C:\PATH\BACKUP\GPSDB\BACKUP\DELETE-BK.bat" echo.'forfiles /p C:\PATH\Backup\GPSDB\BACKUP\DB /S /M *.bak /d -7 /c "cmd /c del echo @FILE"'
schtasks /create /sc DAILY /tn "Backups\GPS Backup" /tr "C:\PATH\BACKUP\GPSDB\BACKUP\SQLBK-DB.bat" /st 23:00 /ru SYSTEM /rl HIGHEST &
schtasks /create /sc DAILY /tn "Backups\GPS Backup Delete" /tr "C:\PATH\BACKUP\GPSDB\BACKUP\Delete BK.bat" /st 23:30 /ru SYSTEM /rl HIGHEST &
PAUSE
EXIT
