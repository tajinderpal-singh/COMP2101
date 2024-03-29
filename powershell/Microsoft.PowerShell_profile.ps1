$env:path += ";$home/documents/github/COMP2101/powershell"
$env:path += ";C:\users\tajinderpal\documents\github\comp2101\powershell"

New-Alias -Name np -Value notepad
function welcome {
# Lab 2 COMP2101 welcome script for profile
#

 write-output "Welcome to planet $env:computername Overload $env:username"
 $now = get-date -format 'HH:MM tt on dddd'
 write-output "It is $now."
 }

function get-cpuinfo {
# Displays cpu information

 $processors = get-ciminstance cim_processor
 foreach ($processor in $processors) {
	write-host "Manufacturer: $($processor.Manufacturer)"
	write-host "Model: $($processor.Name)"
	write-host "Current Speed: $($processor.CurrentClockSpeed) MHz"
	write-host "Maximum Speed: $($processor.MaxClockSpeed) MHz"
	write-host "Number of Cores: $($processor.NumberOfCores)"
	write-host "================"
 }
}

function get-mydisks {
	Get-PhysicalDisk | Select-Object Manufacturer, Model, SerialNumber, FirmwareRevision, Size | Format-Table
}