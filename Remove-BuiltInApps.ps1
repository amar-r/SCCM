$AppxPackage = Get-AppxProvisionedPackage -Online

Foreach ($app in $AppxPackage) {
    #Write-Host "$($app.DisplayName) | $($app.PackageName)"

    Switch ($app.DisplayName) {
        {$app.DisplayName -match '3DViewer'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName} 
        {$app.DisplayName -match 'FeedbackHub'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'GetHelp'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'GetStarted'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'Maps'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'Messaging'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'MixedReality.Portal'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'OfficeHub'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'OneConnect'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'People'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'SolitaireCollection'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'Wallet'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'Xbox.TCUI'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'XboxApp'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'XboxGameOverlay'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'XboxGamingOverlay'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'XboxIdentityProvider'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'XboxSPeechToTextOverlay'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'YourPhone'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'ZuneMusic'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'ZuneVideo'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'communicationsapps'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}
        {$app.DisplayName -match 'BingWeather'} {Remove-AppxProvisionedPackage -Online -AllUsers -PackageName $app.PackageName}       
    }
}
