Configuration Sample_InstallJre8
{
<#
    param
    (
    [Parameter(Mandatory)]
    $Language,

    [Parameter(Mandatory)]
    $LocalPath
)
#>  
    Import-DscResource -module Applications

    InstallJre8 Jre8 {}
}

$MOFPath = 'C:\MOF'
If (!(Test-Path $MOFPath)){New-Item -Path $MOFPath -ItemType Directory}
Sample_InstallJre8 -OutputPath $MOFPath
Start-DscConfiguration -Path $MOFPath -Wait -Force -Verbose