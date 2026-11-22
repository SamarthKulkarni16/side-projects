# PC scheduled tasks (Director's Windows 7 PC) - reference written 2026-11-22
Read this instead of searching the PC again. All commands: run in Command Prompt AS ADMINISTRATOR (Start, type cmd, right-click, Run as administrator), ONE line, output goes to a Desktop txt and opens in Notepad (he cannot copy from the cmd window).

## Tasks (Task Scheduler, names exact)
| Task | What it does | Normal time | State since 2026-11-22 |
|---|---|---|---|
| PCLock2 | runs lock6.ps1: full-screen black lock form (password in lock.ps1, not stored here), EndAt 06:55 | daily 06:10 | DISABLED (not deleted) |
| PCLock | runs lock.ps1: same lock form, EndAt 08:55 | daily 08:00 | DISABLED (not deleted) |
| PCShutdownPM | runs `shutdown /s /t 60` as SYSTEM (60 s warning) | was 15:59 daily | moved to 17:05 and ENABLED (2026-11-22) |
The lock scripts contain NO command that closes Chrome. Files: repo side-projects, folder pc-lock/ (lock.ps1, tasks/ XML, logs/).

## Why they changed (Director, 2026-11-22)
The three slots became autoposter windows (52 posts per clip day need about 190 min): 06:10-06:55, 08:00-08:55, 13:00-14:00 (c4_daily cron), plus an optional 16:00-17:00. Google Calendar has daily events "PC posting window 1/2/3" for 06:10, 08:00, 16:00. The PC shuts down at 17:05 so it does not stay on overnight; he is out after 17:00.

## Commands (copy exactly; each writes %USERPROFILE%\Desktop\<name>.txt and opens it)
STOP both locks now (disable, not delete, and end a running lock):
(echo ==== %date% %time% ==== & schtasks /Change /TN PCLock /DISABLE & schtasks /Change /TN PCLock2 /DISABLE & schtasks /End /TN PCLock & schtasks /End /TN PCLock2 & echo ---- state & schtasks /Query /TN PCLock /FO LIST /V | findstr /i "TaskName State Next" & schtasks /Query /TN PCLock2 /FO LIST /V | findstr /i "TaskName State Next") > "%USERPROFILE%\Desktop\lock_off.txt" 2>&1 & notepad "%USERPROFILE%\Desktop\lock_off.txt"

START the locks again (same line with /ENABLE, no /End):
(echo ==== %date% %time% ==== & schtasks /Change /TN PCLock /ENABLE & schtasks /Change /TN PCLock2 /ENABLE & schtasks /Query /TN PCLock /FO LIST /V | findstr /i "TaskName State Next" & schtasks /Query /TN PCLock2 /FO LIST /V | findstr /i "TaskName State Next") > "%USERPROFILE%\Desktop\lock_on.txt" 2>&1 & notepad "%USERPROFILE%\Desktop\lock_on.txt"

FIND what shuts the PC down (read-only, how PCShutdownPM was found):
(echo ==== %date% %time% ==== & echo -- tasks that run shutdown & powershell -NoProfile -Command "schtasks /Query /FO CSV /V | ConvertFrom-Csv | Where-Object { $_.'Task To Run' -match 'shutdown|poweroff|psshutdown' } | Format-List TaskName,'Task To Run','Scheduled Task State','Next Run Time','Run As User'" & echo -- startup folders & dir /b "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup" & echo -- run keys & reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run & reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run) > "%USERPROFILE%\Desktop\shutdown_find.txt" 2>&1 & notepad "%USERPROFILE%\Desktop\shutdown_find.txt"

DISABLE the shutdown (used 2026-11-22 06:00):
(echo ==== %date% %time% ==== & schtasks /Change /TN PCShutdownPM /DISABLE & schtasks /Query /TN PCShutdownPM /FO LIST /V | findstr /i "TaskName State Next") > "%USERPROFILE%\Desktop\shutdown_off.txt" 2>&1 & notepad "%USERPROFILE%\Desktop\shutdown_off.txt"

MOVE the shutdown to 17:05 and enable it (current setting):
(echo ==== %date% %time% ==== & schtasks /Change /TN PCShutdownPM /ST 17:05 /ENABLE & schtasks /Query /TN PCShutdownPM /FO LIST /V | findstr /i "TaskName Task.To.Run State Next Schedule") > "%USERPROFILE%\Desktop\shutdown_1705.txt" 2>&1 & notepad "%USERPROFILE%\Desktop\shutdown_1705.txt"

STATUS of all three (read-only):
(echo ==== %date% %time% ==== & for %t in (PCLock PCLock2 PCShutdownPM) do schtasks /Query /TN %t /FO LIST /V | findstr /i "TaskName State Next") > "%USERPROFILE%\Desktop\pc_tasks.txt" 2>&1 & notepad "%USERPROFILE%\Desktop\pc_tasks.txt"
(In a .bat file use %%t instead of %t.)

## Other things found on the PC (2026-11-22)
Startup folder: chrome_maximize.vbs (keeps Chrome maximized, skips the autoposter Chrome), Adobe Gamma Loader. Run keys: Web Companion, f.lux, PicPick, SoundMan. AutoHotkey is not installed.
Known quirk: "schtasks /Query /FO CSV /NH" works, but /NH cannot be combined with /FO LIST.
