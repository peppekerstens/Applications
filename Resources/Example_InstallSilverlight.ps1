Configuration Sample_InstallSilverlight
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

    InstallSilverlight Silverlight {}
}

$MOFPath = 'C:\MOF'
If (!(Test-Path $MOFPath)){New-Item -Path $MOFPath -ItemType Directory}
Sample_InstallSilverlight -OutputPath $MOFPath
Start-DscConfiguration -Path $MOFPath -Wait -Force -Verbose