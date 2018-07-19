# Services Toggler

Stop allowing programs to run a bunch of Services on startup that you use circumstantially. This prevents a bunch of services from consuming precious CPU resources on startup. 

You can use this script for a 1-click solution to manually starting/stopping a service.

You can duplicate this script file to have many of these for all your Service needs in one folder. 

This script doesn't need to be in a specific directory. Just plug and play.

---

This script comes complete with a few customizable variables.

- $ServiceName

  Name of service you want to start and stop. Please note this is the service name, **NOT** the Display Name. If you aren't sure, navigate to services.msc and right click > properties on the service of choice to get the actual Serivce name.

- $ShowOutput (String | default: "Hidden")

  This will simply pause the script at the end for you to review any errors or custom output messages.

  Possible values for $ShowOutput are => Normal, Hidden, Minimized, Maximized

- $TryWait (Integer | default: 30)

  This is the amount of time, in seconds, to wait to see if the service successfully stopped. This does not mean it was unsuccessful at stopping, as some services take longer to stop. If it was not successful a system prompt will populate to notify you and take you to the services manager where you can troubleshoot if desired.

- $RenameFile (Boolean | default: $true)

  Rename the current file's name to reflect the service status. For example, if user starts a service, this file's name will change to "Stop <ServiceName>", and if the service was successfully stopped, the new file name of this script will be "Start <ServiceName>" to easily help you identify the service status and possible action for next run.

  Possible values for $RenameFile => $true, $false
