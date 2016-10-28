
### The InstallClassic-Shell DSC Resource is implemented as a "composite" DSC Resource, which is
### a DSC Configuration Document comprised of other DSC Resource instances. Consequently,
### the InstallClassic-Shell DSC Resource does not implement its own Get, Test, and Set methods.

Configuration InstallClassic-Shell
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
    OneGetPackage Classic-Shell
    {
        Name = 'Classic-Shell'
        Source = 'Chocolatey'
        Ensure = 'Present'
        DependsOn = '[OneGetPackageProvider]Chocolatey'
    }
<#
    #POST actions
    Registry AllowWebcam32
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Silverlight"
        ValueName = "AllowWebcam"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Classic-Shell'
    }

    Registry DRMEnabled32
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Silverlight"
        ValueName = "DRMEnabled"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Silverlight'
    }

    Registry UpdateConsentMode32
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Silverlight"
        ValueName = "UpdateConsentMode"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Silverlight'
    }

    Registry UpdateMode32
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Silverlight"
        ValueName = "UpdateMode"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Silverlight'
    }


    Registry AllowWebcam64
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Microsoft\Silverlight"
        ValueName = "EnableJavaUpdate"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Silverlight'
    }

    Registry DRMEnabled64
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Microsoft\Silverlight"
        ValueName = "DRMEnabled"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Silverlight'
    }

    Registry UpdateConsentMode64
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Microsoft\Silverlight"
        ValueName = "UpdateConsentMode"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Silverlight'
    }

    Registry UpdateMode64
    {
        Key = "HKEY_LOCAL_MACHINE\Software\Microsoft\Silverlight"
        ValueName = "UpdateMode"
        Ensure = 'Present' 
        ValueData = 0
        ValueType = 'Dword'
        DependsOn = '[OneGetPackage]Silverlight'
    }
<#
#64Bit disable silverlight features settings
New-Item -Path "HKLM:\Software\Wow6432Node\Microsoft\Silverlight"
New-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Silverlight" -Name AllowWebcam -Value 0 -PropertyType DWord
New-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Silverlight" -Name DRMEnabled -Value 0 -PropertyType DWord
New-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Silverlight" -Name UpdateConsentMode -Value 0 -PropertyType DWord
New-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Silverlight" -Name UpdateMode -Value 2 -PropertyType DWord

#32Bit disable silverlight features settings
New-Item -Path "HKLM:\Software\Microsoft\Silverlight" 
New-ItemProperty -Path "HKLM:\Software\Microsoft\Silverlight" -Name AllowWebcam -Value 0 -PropertyType DWord
New-ItemProperty -Path "HKLM:\Software\Microsoft\Silverlight" -Name DRMEnabled -Value 0 -PropertyType DWord
New-ItemProperty -Path "HKLM:\Software\Microsoft\Silverlight" -Name UpdateConsentMode -Value 0 -PropertyType DWord
New-ItemProperty -Path "HKLM:\Software\Microsoft\Silverlight" -Name UpdateMode -Value 2 -PropertyType DWord
#>


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
