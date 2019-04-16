‪currentWU = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" | Select-Object -ExpandProperty UseWUServer‬
‪Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value 0‬
‪Restart-Service wuauserv‬
‪Get-WindowsCapability -Name 'Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0' -Online | Add-WindowsCapability –Online‬
‪Get-WindowsCapability -Name 'Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0' -Online | Add-WindowsCapability –Online‬
‪Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value $currentWU‬
