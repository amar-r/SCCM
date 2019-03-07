# ----------------------------------------------------------------------------- 
# Author: Amar Rathore
# Date: 2018-01-07
# ----------------------------------------------------------------------------- 
#Requires -RunAsAdministrator

param (
    [Parameter(Mandatory = $true)][String]$computer
)

#$computer = Read-Host -Prompt "Enter computer name"

Write-Host "Working on it...please be patient" -ForegroundColor Cyan -BackgroundColor DarkGray

if (Test-Connection $computer -Count 1 -ea SilentlyContinue) {

    $path = "\\$computer\c$\windows\ccm\logs"

    $smstslog = (Get-ChildItem $path -Recurse -File | Where-Object {$_.Name -match "Smsts"}).FullName
        
    foreach ($file in $smstslog) {
        
        $success = (Get-Content $file | Where-Object {$_ -match "Successfully completed the action"}) -replace '.*\(' -replace '\).*'
        $fail = (Get-Content $file | Where-Object {$_ -match "Failed to run the action"}) -replace '.*\: ' | Where-Object {$_ -notmatch 'Set fail status.'}
        $oPath = $file -replace '.*\windows\\'
                
        if (($null -ne $success) -or ($null -ne $fail)) {
            Write-Host "`n Log location:" $oPath -ForegroundColor Green -BackgroundColor DarkGray $file.CreationTime
            Write-Host "`nSucceeded on the following steps:" -ForegroundColor Green -BackgroundColor Black
            $success

        }
        
        if ($null -ne $fail) {
            Write-Host "`n Log location:"$oPath -ForegroundColor Green -BackgroundColor DarkGray $file.CreationTime
            Write-Host "`nFailed the following steps:" -ForegroundColor Red -BackgroundColor Black
            $fail            
        }
        
    }

}
else {Write-Host "Error: $computer is unreachable" -ForegroundColor Red -BackgroundColor Black}
