get-childitem 'C:\Program Files\Microsoft Dynamics CRM\Server\bin\assembly\*.dll' -Exclude 'EntityFramework*' | foreach {
    $Assembly = $_
    if ( Get-ChildItem C:\Windows\Microsoft.NET\assembly\GAC_MSIL | where name -eq $Assembly.BaseName ) {
            Write-Output "Uninstall / reinstall $($Assembly.Name)"
            & 'C:\Releases\NETFX 4.0 Tools\gacutil.exe' /u $Assembly.Name
            & 'C:\Releases\NETFX 4.0 Tools\gacutil.exe' /i $Assembly.FullName
           #Start-Process -FilePath 'C:\Releases\NETFX 4.0 Tools\gacutil.exe' -ArgumentList "/u $($_.Name)" -Wait
            #Start-Process -FilePath 'C:\Releases\NETFX 4.0 Tools\gacutil.exe' -ArgumentList "/i $($_.FullName)" -Wait
        }
        else {
            Write-Output "Install $($Assembly.Name)"
            & 'C:\Releases\NETFX 4.0 Tools\gacutil.exe' /i $Assembly.FullName
    }
}
