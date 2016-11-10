Configuration Sample_InstallJavaRuntime
{
    Import-DscResource -module Applications

    InstallJavaRuntime JavaRuntime {}
}

$MOFPath = 'C:\MOF'
If (!(Test-Path $MOFPath)){New-Item -Path $MOFPath -ItemType Directory}
Sample_InstallJavaRuntime -OutputPath $MOFPath
Start-DscConfiguration -Path $MOFPath -Wait -Force -Verbose