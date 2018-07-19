<#
  .SYNOPSIS
    Runs a specified service, or stops it if it already is running. This does NOT take into account if the service is paused,
    that's probably an intended action by the user so I decided not to proceed if that was the case.

  .DESCRIPTION
    User can change name of service with the $ServiceName variable.

    User can elect to show the window when running or not by altering the $ShowOutput variable.
    Showing the window simply displays results from the script, with any error messages as received.

    Possible values for $ShowOutput are => Normal, Hidden, Minimized, Maximized

    $TryWait is the amount of time, in seconds, to wait to see if the service successfully stopped. This does not mean it was unsuccessful at stopping, as some services take longer to stop. If it was not successful a system prompt will populate to notify you and take you to the services manager where you can troubleshoot if desired.

    User can elect to rename the current file's name to reflect the service status. For example,
    If user starts a service, this file's name will change to "Stop <ServiceName>", and if the service was
    successfully stopped, the new file name of this script will be "Start <ServiceName>" to easily help you identify the service status.
    This feature can be toggled with the $RenameFile variable.

    Possible values for $RenameFile => $true, $false

    NOTICE: When successfully stopped a service, the filename will not change until after the $TryWait time has elapsed.

  .NOTES
    Version         =  1.0
    Privileges      =  Requires Admin access. Aborts otherwise, most likely with UAC error.
                        UAC prompt is provided to maintain user control.
    Author(s)       =  David Freer (soulshined@me.com)
    Compatibility   =  This script is compatible with >= Windows 7.0
#>

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# :::::::::::::::::::::::::::::::::::::  VARS  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
$ServiceName = "MSSQLSERVER"
$ShowOutput = "Hidden"
$TryWait = 30
$RenameFile = $true
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# :::::::::::::::::::::::::::::::::::  FUNCTIONS  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function Out($msg) {
 Write-Host $msg`n
}
#Returns true/false if current powershell window is running as Admin
function IsAdmin {
  if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
  {
    $?
  }
}
#Renames current file to reflect Service status, if permission is given via $RenameFile
function ToggleFileName {
  $Name = switch ($ServiceObj.Status) {
    "Running" { "Stop $ServiceName.ps1"  }
    "Stopped" { "Run $ServiceName.ps1" }
    "Paused" { "Run $ServiceName.ps1" }
    Default { $ServiceName + " is " + $ServiceObj.Status }
  }
  if ($RenameFile -eq $true) {
    Rename-Item -Path $PSCommandPath -NewName $Name
  }
}
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ::::::::::::::::::::::::::::::::::::  PROCESS  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if (!(IsAdmin))
{
  # -> ExecutionPolicy Bypass is safer than setting environment Execution Policy. This restricts the change to session only.
  #   => -File simply makes sure the commands below are run from the path of current script
  Start-Process Powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -WindowStyle $ShowOutput -Verb runAs
  Exit
}

try {
  $ServiceObj = Get-Service -Name $ServiceName -ErrorAction Stop #Stop forces termination for any error/warning

  # We only care about 2 states, running and stopped, otherwise do nothing but update the filename, if allowed
  if ($ServiceObj.Status -eq "Running") {
    try {
      Stop-Service -Name $ServiceName -ErrorAction Stop

      Start-Sleep $TryWait

      $ServiceObj.Refresh()
      if ($ServiceObj.Status -eq "Stopped") {
        Out("$ServiceName service successfully stopped")
      } else {
        Add-Type -AssemblyName PresentationCore, PresentationFramework

        $Response = [System.Windows.MessageBox]::Show("The $ServiceName service could not be stopped successfully. Would you like to open the services manager to manually stop it?", "Service Error", [System.Windows.MessageBoxButton]::YesNo, [System.Windows.MessageBoxImage]::Warning)

        if ($Response -eq "Yes") {
          Start-Service services.msc
        }
      }
    }
    catch {
      Out($_.Exception.Message)
    }
  }
  else {
    if ($ServiceObj.Status -eq "Stopped") {
      try {
        Start-Service -Name $ServiceName

        $ServiceObj.Refresh()
        if ($ServiceObj.Status -eq "Running") {
          Out("$ServiceName service successfully started")
        } else {
          Out("$ServiceName service status unknown")
        }
      }
      catch {
        Out($_.Exception.Message)
      }
    }
  }
}
catch {
  Out($_.Exception.Message) #Usually no service found of the name $ServiceName
}

ToggleFileName
if ($ShowOutput -ne "Hidden") { pause }
