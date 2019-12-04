<#
.DESCRIPTION
  Parses through the SMSTS log and returns the steps which succeeded, steps which failed, comptuer name, timestamp, and log name. 
.PARAMETER Computer
  To view a remote machine's logs use this parameter to define the machine name. 
.PARAMETER Path
  If for some reason the SMSTS log is not located in C:\Windows\CCM\Logs, use this parameter to define the folder path (Accepts UNC Paths)

.NOTES
  Version:        1.0
  Author:         Amar Rathore
  Creation Date:  2019-03-25

.EXAMPLE
  Read-SMSTSLog.ps1 -Computer PC01

.EXAMPLE
  Read-SMSTSLog.ps1 -Path X:\Windows\Temp\
#>

[CmdletBinding()]

Param (    
    [string]$Computer = "$env:ComputerName",
    [string]$Path = "\\$computer\c$\Windows\CCM\Logs",
    [pscredential]$Credential
)

If (Test-Connection $Computer -Count 1 -ErrorAction  SilentlyContinue) {

    function Read-Log {
        param (
            [Parameter(Mandatory = $true)][ValidateSet ('Success', 'Fail')][string]$status
        )        

        Switch ($status) {
            'Success' { $Pattern = 'Win32 Code 0'; $Regex = '\<\!\[LOG.*\((?<Message>\w+|.*)\).*\]LOG]\!\>\<time=\"(?<Time>.{12}).*date=\"(?<Date>.{10})' }
            'Fail' { $Pattern = 'Failed to run the action'; $Regex = '.*:\s(?<Message>.*|.*\n.*)\]\w+\].{3}time\S{2}(?<Time>.{12}).*date\S{2}(?<Date>.{10})' }
        }

        Get-Content $file | Select-String -Pattern $Pattern -Context 1| ForEach-Object {
            $_ -match $Regex | Out-Null

            [PSCustomObject]@{
                Computer = $Computer
                Time     = [datetime]::ParseExact($("$($matches.date) $($matches.time)"), "MM-dd-yyyy HH:mm:ss.fff", $null)
                Message  = $Matches.Message
                File     = $File
            }
        } | Format-Table -AutoSize
    }

    If ($PSBoundParameters.ContainsKey('Credential')) {
      New-PSDrive -Name $Computer -PSProvider FileSystem -Root "\\$Computer\c$" -Credential $Credential -ErrorAction Stop | Out-Null
    }

    If (Test-Path $path){
        $smstslog = (Get-ChildItem $path -Recurse -File | Where-Object {$_.Name -match "Smsts"}).FullName
    }
    Else {
      Write-Host "Unable to connect to $Path.`nIf you're attempting to connect to a remote machine try using the UNC path" -ForegroundColor Red -BackgroundColor Black
      return
    }

    $s = ForEach ($file in $smstslog) {Read-log -status 'Success'}
    $f = ForEach ($file in $smstslog) {Read-log -status 'Fail'}

    If ($s) {Write-host "`nCompleted the following steps:" -ForegroundColor Green -BackgroundColor Black; $s}
    If ($f) {Write-host 'Failed the following steps:' -ForegroundColor Red -BackgroundColor Black; $f}

    If (Get-PSDrive -Name $Computer) { 
      try {
        Remove-PSDrive -Name $Computer -ErrorAction Stop
      }
      catch {
        Write-Warning "Failed to remove PS drive `"${Computer}:`""
      }
    }
}
Else {
    Write-host "$Computer is offline/unreachable" -ForegroundColor Red -BackgroundColor Black
}
