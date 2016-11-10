
### The InstallJavaRuntime DSC Resource is implemented as a "composite" DSC Resource, which is
### a DSC Configuration Document comprised of other DSC Resource instances. Consequently,
### the InstallJavaRuntime DSC Resource does not implement its own Get, Test, and Set methods.

Configuration InstallJavaRuntime
{

    Import-DSCResource -ModuleName PSDesiredStateConfiguration, OneGetPackage

    #PRE actions
    OneGetPackageProvider NuGet
    {
        Name = 'NuGet'
    }

    OneGetPackageProvider Chocolatey
    {
        Name = 'Chocolatey'
        DependsOn = '[OneGetPackageProvider]NuGet'
    }

    #INSTALL
    OneGetPackage JavaRuntime
    {
        Name = 'javaruntime'
        Source = 'Chocolatey'
        Ensure = 'Present'
        DependsOn = '[OneGetPackageProvider]Chocolatey'
    }

    #POST actions
    Registry EnableJavaUpdate32
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Wow6432Node\JavaSoft\Java Update\Policy"
        ValueName = "EnableJavaUpdate"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Jre8'
    }

    Registry NotifyDownload32
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Wow6432Node\JavaSoft\Java Update\Policy"
        ValueName = "NotifyDownload"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Jre8'
    }

    Registry NotifyInstall32
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Wow6432Node\JavaSoft\Java Update\Policy"
        ValueName = "NotifyInstall"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Jre8'
    }

    Registry EnableJavaUpdate64
    {
        Key = "HKEY_LOCAL_MACHINE\Software\JavaSoft\Java Update\Policy"
        ValueName = "EnableJavaUpdate"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Jre8'
    }

    Registry NotifyDownload64
    {
        Key = "HKEY_LOCAL_MACHINE\Software\JavaSoft\Java Update\Policy"
        ValueName = "NotifyDownload"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Jre8'
    }

    Registry NotifyInstall64
    {
        Key = "HKEY_LOCAL_MACHINE\Software\JavaSoft\Java Update\Policy"
        ValueName = "NotifyInstall"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Jre8'
    }
<#
#NOT implemented (YET)

#Disable use of next-gen java plugin 32bit
#Adjust the value to the current java version!
$BrowserJavaVersion = (Get-ItemProperty -Path "HKLM:\Software\Wow6432Node\JavaSoft\Java Runtime Environment" -name "BrowserJavaVersion").BrowserJavaVersion
Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\JavaSoft\Java Plug-in\$BrowserJavaVersion" -Name UseNewJavaPlugin -Value 0

#Copy deployment configuration files
#http://docs.oracle.com/javase/7/docs/technotes/guides/jweb/jcp/properties.html
New-Item "$env:windir\SUN\Java\Deployment" -ItemType Directory
Copy-Item "$($Install)\deployment.config" "$env:windir\Sun\Java\Deployment" -Force
Copy-Item "$($Install)\deployment.properties" "$env:windir\Sun\Java\Deployment" -Force
#>
}
