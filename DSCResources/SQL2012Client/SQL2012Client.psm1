
### The SQL2012Client DSC Resource is implemented as a "composite" DSC Resource, which is
### a DSC Configuration Document comprised of other DSC Resource instances. Consequently,
### the SQL2012Client DSC Resource does not implement its own Get, Test, and Set methods.

Configuration SQL2012Client
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
    OneGetPackage Silverlight
    {
        Name = 'sql2012.nativeclient'
        Source = 'Chocolatey'
        Ensure = 'Present'
        DependsOn = '[OneGetPackageProvider]Chocolatey'
    }

    #POST actions
}
