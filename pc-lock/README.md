# PC morning lock (Windows 7 PC, user KULKARNI)

A full-screen black lock with a clock that blocks the PC at set times. It ends by itself at the end time, or earlier when the password is typed on the keyboard.

## How it is built
- Script on the PC: `C:\Users\KULKARNI\lock.ps1` (copy here: `lock.ps1`; the password in it is REDACTED in this repo). Parameter `-EndAt HH:mm` (default 08:55), `-Test` runs for 20 seconds.
- Scheduled task `PCLock`: daily 08:00, runs `lock.ps1` (ends 08:55). Created 2026-10-28. XML: `tasks/PCLock.xml`.
- Scheduled task `PCLock2`: daily 06:10, runs `lock.ps1 -EndAt 06:55`. Created 2026-11-07. XML: `tasks/PCLock2.xml`. First real run could not be tested on 2026-11-08 because the PC was off.
- Both tasks: interactive logon only, do not start on battery.

## AutoHotkey
`shortcuts.ahk` (typed `ttt` gave the time, `ddd` the date) launched at every startup. On 2026-11-08 it was moved out of the Startup folder to `C:\Users\KULKARNI\Disabled_Startup`. The already running AutoHotkey process (PID 3908) was still alive after the move, so it stops only after a restart or when that process is closed.

## Logs
`logs/` holds the PC command outputs that discovered all of this (lock scan 1 to 3, the PCLock2 creation, the AutoHotkey disable). They were moved from the hq repo status folder. The password line was redacted. NOTE: the old password is still in the git history of hq, so change it.

The PC itself is reached through the PC agent tunnel that belongs to the autoposter in hq (not moved).
