$modules = 'C:\Users\peppe\Documents\GitHub\Applications\DSCResources'
$modulename = 'InstallSilverlight'
$Description = 'This module is used to install JavaRuntime on a system. Functionality is limited to install'

#if (!(test-path (join-path $modules $modulename))) {

    $modulefolder = mkdir (join-path $modules $modulename)
    New-ModuleManifest -Path (join-path $modulefolder "$modulename.psd1") -Guid $([system.guid]::newguid().guid) -Author 'Peppe Kerstens' -CompanyName 'ITON Services BV' -Copyright '2016' -ModuleVersion '1.0.0.0' -Description $Description -PowerShellVersion '5.1'
<#
    $standard = @{ModuleName = $modulename
                ClassVersion = '1.0.0.0'
                Path = $modules
                }
    $P = @()
    $P += New-xDscResourceProperty -Name Action -Type String -Attribute Key -ValidateSet 'Install','Update','Uninstall' -Description 'Determines whether should be installed, updated or uninstalled'
    New-xDscResource -Name JavaRuntime -Property $P -FriendlyName InstallJavaRuntime @standard
#>
#}