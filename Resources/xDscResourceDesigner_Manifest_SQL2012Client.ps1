#Assumes being called from existing 'resources directory in this module
$currentpath = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$modules = join-path $currentpath ..\DSCResources

$modulename = 'SQL2012Client'
$Description = 'This module is used to install the SQL2012 client on a system. Functionality is limited to install'
$modulefolder = join-path $modules $modulename

if (!(test-path (join-path $modules $modulename))) { mkdir $modulefolder }

New-ModuleManifest -Path (join-path $modulefolder "$modulename.psd1") -Guid $([system.guid]::newguid().guid) -Author 'Peppe Kerstens' -CompanyName 'ITON Services BV' -Copyright '2016' -ModuleVersion '1.0.0.0' -Description $Description -PowerShellVersion '5.1'