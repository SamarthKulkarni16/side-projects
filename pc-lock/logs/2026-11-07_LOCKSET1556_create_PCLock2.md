PC heartbeat: 2026-11-07 15:54:17 alive
QUEUED LOCKSET1556
RESULT AFTER 20s
command: LOCKSET1556.bat
started: 2026-11-07 15:56:29
finished: 2026-11-07 15:56:31
exit code: 0
--- output ---
===== CREATE PCLock2 - daily 06:10, ends 06:55
Sat 11/07/2026 
03:56 PM
SUCCESS: The scheduled task "PCLock2" has successfully been created.

===== VERIFY PCLock2

Folder: \
HostName:                             KULKARNI-PC
TaskName:                             \PCLock2
Next Run Time:                        11/8/2026 6:10:00 AM
Status:                               Ready
Logon Mode:                           Interactive only
Last Run Time:                        N/A
Last Result:                          1
Author:                               KULKARNI
Task To Run:                          powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\Users\KULKARNI\lock.ps1" -EndAt 06:55
Start In:                             N/A
Comment:                              N/A
Scheduled Task State:                 Enabled
Idle Time:                            Disabled
Power Management:                     Stop On Battery Mode, No Start On Batteries
Run As User:                          KULKARNI-PC\KULKARNI
Delete Task If Not Rescheduled:       Enabled
Stop Task If Runs X Hours and X Mins: 72:00:00
Schedule:                             Scheduling data is not available in this format.
Schedule Type:                        Daily 
Start Time:                           6:10:00 AM
Start Date:                           11/7/2026
End Date:                             N/A
Days:                                 Every 1 day(s)
Months:                               N/A
Repeat: Every:                        Disabled
Repeat: Until: Time:                  Disabled
Repeat: Until: Duration:              Disabled
Repeat: Stop If Still Running:        Disabled

===== PCLock2 XML
(task XML: see ../tasks/PCLock2.xml)
===== PCLock 8:00 STILL THERE

Folder: \
HostName:      KULKARNI-PC
TaskName:      \PCLock
Next Run Time: 11/8/2026 8:00:00 AM
Status:        Ready
Logon Mode:    Interactive only

===== END
