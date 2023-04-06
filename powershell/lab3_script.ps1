# This is the script to show the ip configuration for the computer

$adapters = get-ciminstance win32_networkadapterconfiguration | where-object { $_.ipenabled }
$Output = foreach ($adapter in $adapters) {
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