param([switch]$Test, [string]$EndAt = '08:55')
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
if ($Test) {
  $script:end = (Get-Date).AddSeconds(20)
} else {
  $parts = $EndAt.Split(':')
  $script:end = (Get-Date).Date.AddHours([int]$parts[0]).AddMinutes([int]$parts[1])
}
if ((Get-Date) -ge $script:end) { exit }
$script:pw = '<REDACTED - the real password is only in the copy on the PC>'
$script:buf = ''
$script:ok = $false
$script:b = [System.Windows.Forms.SystemInformation]::VirtualScreen
$script:p = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$script:f = New-Object System.Windows.Forms.Form
$script:f.FormBorderStyle = 'None'
$script:f.StartPosition = 'Manual'
$script:f.Location = $script:b.Location
$script:f.Size = $script:b.Size
$script:f.BackColor = [System.Drawing.Color]::Black
$script:f.TopMost = $true
$script:f.ShowInTaskbar = $false
$script:f.KeyPreview = $true
$script:l = New-Object System.Windows.Forms.Label
$script:l.AutoSize = $false
$script:l.Left = $script:p.X - $script:b.X
$script:l.Top = $script:p.Y - $script:b.Y
$script:l.Width = $script:p.Width
$script:l.Height = $script:p.Height
$script:l.TextAlign = 'MiddleCenter'
$script:l.Text = (Get-Date).ToString('HH:mm')
$script:l.ForeColor = [System.Drawing.Color]::White
$script:l.BackColor = [System.Drawing.Color]::Black
$script:l.Font = New-Object System.Drawing.Font('Segoe UI', 40)
$script:f.Controls.Add($script:l)
$script:f.Add_Shown({ $script:f.Activate() })
$script:f.Add_KeyPress({
  param($s, $e)
  $script:buf = $script:buf + [string]$e.KeyChar
  if ($script:buf.Length -gt 40) { $script:buf = $script:buf.Substring($script:buf.Length - 40) }
  if ($script:buf.EndsWith($script:pw, [System.StringComparison]::Ordinal)) { $script:ok = $true; $script:f.Close() }
})
$script:f.Add_FormClosing({
  param($s, $e)
  if ((-not $script:ok) -and ($e.CloseReason -ne [System.Windows.Forms.CloseReason]::WindowsShutDown)) { $e.Cancel = $true }
})
$script:tm = New-Object System.Windows.Forms.Timer
$script:tm.Interval = 1000
$script:tm.Add_Tick({
  if ((Get-Date) -ge $script:end) { $script:ok = $true; $script:f.Close() }
  else { $script:l.Text = (Get-Date).ToString('HH:mm'); $script:f.TopMost = $true; $script:f.Activate() }
})
$script:tm.Start()
[System.Windows.Forms.Cursor]::Hide()
[void]$script:f.ShowDialog()
[System.Windows.Forms.Cursor]::Show()
