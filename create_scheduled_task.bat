:: Docs: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/schtasks-create

:: SC - Schedule type
:: TN - Task Name
:: D - Day
:: TR - Task Run
:: ST - Start Time
:: RL - Run Level

schtasks /create /sc WEEKLY /tn "TASK NAME" /d MON /tr "C:\PATH\script.bat" /st 23:00 /rl HIGHEST
