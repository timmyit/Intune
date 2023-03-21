# Install Powershell module
Install-Module -Name Microsoft.Graph.Intune -Force
Import-Module -Name Microsoft.Graph.Intune 

# Connect to Graph
Connect-MSGraph -ForceInteractive
Update-MSGraphEnvironment -SchemaVersion beta
Connect-MSGraph
 
# Which AAD group do we want to check against
$groupName = "Android-Samsung-Xcover5"
 
#$Groups = Get-AADGroup | Get-MSGraphAllPages
$Group = Get-AADGroup -Filter "displayname eq '$GroupName'"

$DeviceGroupMember = Get-AADGroupMember -groupId $group.id | Get-MSGraphAllPages
 

Foreach ($Device in $DeviceGroupMember) 
    {
        
       $De = Get-IntuneManagedDevice -managedDeviceId $Device.deviceId 
       
       $De.serialNumber | Out-File c:\temp\Serial.csv -Append
       

     }


