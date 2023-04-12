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

function get-computerinfo {
  $computerSystem = Get-CimInstance win32_computersystem
  $name = $computerSystem.Name
  $manufacturer = $computerSystem.Manufacturer
  $model = $computerSystem.Model
  $totalphysicalmemory = ($computerSystem.TotalPhysicalMemory | Measure-Object -Sum).Sum / 1GB

  # Output for Part 1
  "1) Computer System Information"
  new-object -typename psobject -property @{
       'Name' = $name
       'Manufacturer' = $manufacturer
       'Model' = $model
       'Total Physical Memory' = $totalphysicalmemory
  } | format-list
}

function get-osinfo {
  $operatingsystem = Get-CimInstance win32_operatingsystem
  $name = $operatingsystem.Caption
  $version = $operatingsystem.Version

  #Output for Part 2
  "2) The Operating System Information is as follow"
  new-object -typename psobject -property @{
       'Name' = $name
       'Version' = $version
  } | format-list
}

function get-processor {
  $processorinfo = Get-CimInstance win32_processor
  $description = $processorinfo.Caption
  $speed = $processorinfo.MaxClockSpeed
  $numberofcores = $processorinfo.NumberOfCores
  $L1cache = "{0} KB" -f $processorinfo.L1CaheSize
  $L2cache = "{0} KB" -f $processorinfo.L2CacheSize 
  $L3cache = "{0} KB" -f $processorinfo.L3CacheSize

  #Output for Part 3
  "3) Following is the processor information"
  new-object -typename psobject -property @{
       'Description' = $description
       'Speed' = $speed
       'Number Of Cores' = $numberofcores
       'L1Cache Size' = $L1cache
       'L2Cache Size' = $L2cache
       'L3Cache Size' = $L3cache
  } | format-list
} 

function get-memoryinfo {
  $memoryinfo = Get-CimInstance win32_physicalmemory
  # Part 4a) Getting the table to report memory information for each DIMM 
  $memoryinfotable = @()
  foreach ($memory in $memoryinfo){
     $bank = $memory.BankLabel
     $slot = $memory.DeviceLocator
     $memoryinfotable += new-object -typename psobject -property @{
  	  'Vendor' = $memory.Manufacturer
	  'Description' = $memory.PartNumber
	  'Size' = "{0:N0} GB" -f ($memory.Capacity /1GB)
	  'Bank' = if ($bank) { $bank } else { "N/A" }
	  'Slot' = if ($slot) { $slot } else { "N/A" } 
     }
  }
  # Part 4b) Getting the total RAM installed
  $memorysum = ($memoryinfo.Capacity | measure-object -sum).sum / 1GB

  #Output for Part 4
  "4) Following is the information for the Memory installed in the computer"
  new-object -typename psobject -property @{
      'Memory' = $memoryinfotable
  }  | format-table -Autosize
  new-object -typename psobject -property @{
      'Total Memory Installed' = "{0:N0} GB" -f $memorysum
  } | format-list
} 

function get-diskinfo {
  $diskdrives = Get-CIMInstance win32_diskdrive

    foreach ($disk in $diskdrives) {
        $partitions = $disk | get-cimassociatedinstance -resultclassname win32_diskpartition
        foreach ($partition in $partitions) {
              $logicaldisks = $partition | get-cimassociatedinstance -resultclassname win32_logicaldisk
              foreach ($logicaldisk in $logicaldisks) {
	  	  $sizeGB = [Math]::Round($logicaldisk.Size / 1GB, 2)
                  $freeGB = [Math]::Round($logicaldisk.FreeSpace / 1GB, 2)
                  $freePercent = [Math]::Round($logicaldisk.FreeSpace / $logicaldisk.Size * 100, 2)
		       "5) Following is the disk information"
                       new-object -typename psobject -property @{Vendor = $disk.Manufacturer
							         Model = $disk.Model
							         Disk = $logicaldisk.DeviceID
              						         Size_GB = $sizeGB
					                         FreeSpace_GB = $freeGB
					                         FreeSpace_Percent = $freePercent
                       } | format-table -autosize 
              }
         }
    }
}


function get-networkinfo {
  $adapters = get-ciminstance win32_networkadapterconfiguration | where-object { $_.ipenabled }
  $Output = foreach ($adapter in $adapters) {
  "6) Following is the network adapter configuration" 
  [PSCustomObject]@{
  	  Description = $adapter.Description
	  Index = $adapter.Index
	  IP_Address = $adapter.IPAddress
	  Subnet_Mask = $adapter.IPSubnet
	  DNS_Domain = $adapter.DNSDomain
	  DNS_Servers = $adapter.DNSServerSearchOrder
   }
  }
  $Output | Format-Table -AutoSize
}

function get-videocard {
  $videocard = Get-CimInstance win32_videocontroller
  foreach ($videocontroller in $videocard){
     $resolution = $videocontroller.CurrentHorizontalResolution.tostring() + "x" + $videocontroller.CurrentVerticalResolution.tostring()
     "7) Following is information about video controllers"
      new-object -typename psobject -property @{
	  Vendor = $videocontroller.VideoProcessor
	  Description = $videocontroller.Description
	  Resolution = $resolution
      } | format-table -autosize
  }
}
