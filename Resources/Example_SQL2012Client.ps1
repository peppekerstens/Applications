Configuration Sample_SQL2012Client
{
    Import-DscResource -module Applications

    SQL2012Client SQL2012Client {}
}

$MOFPath = 'C:\MOF'
If (!(Test-Path $MOFPath)){New-Item -Path $MOFPath -ItemType Directory}
Sample_SQL2012Client -OutputPath $MOFPath
Start-DscConfiguration -Path $MOFPath -Wait -Force -Verbose