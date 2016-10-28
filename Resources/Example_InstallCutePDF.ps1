Configuration Sample_InstallCutePDF
{
    Import-DscResource -module Applications

    InstallCutePDF CutePDF{}
}

$MOFPath = 'C:\MOF'
If (!(Test-Path $MOFPath)){New-Item -Path $MOFPath -ItemType Directory}
Sample_InstallCutePDF -OutputPath $MOFPath
Start-DscConfiguration -Path $MOFPath -Wait -Force -Verbose