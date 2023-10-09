Install-Module -Name Microsoft.Graph.DeviceManagement -Force -AllowClobber
Install-Module -Name Microsoft.Graph.Groups -Force -AllowClobber
Import-Module -Name Microsoft.Graph.Groups
Import-Module -Name Microsoft.Graph.DeviceManagement

Connect-MgGraph -scopes Group.Read.All, DeviceManagementManagedDevices.Read.All, DeviceManagementServiceConfig.Read.All, DeviceManagementApps.Read.All, DeviceManagementApps.Read.All, DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All, DeviceManagementApps.ReadWrite.All


### Get Azure AD Group
$groupName = "All-Windows"


$Group = Get-MgGroup -Filter "DisplayName eq '$groupName'"
### Device Compliance Policy

$Resource = "deviceManagement/deviceCompliancePolicies"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)?`$expand=Assignments"
$AllDCPId = (Invoke-MgGraphRequest -Method GET -Uri $uri).Value | Where-Object {$_.assignments.target.groupId -match $Group.id}

Write-host "The following Device Compliance Policies has been assigned to: $($Group.DisplayName)" -ForegroundColor Cyan

foreach ($DCPId in $AllDCPId) {

  Write-host "$($DCPId.DisplayName)" -ForegroundColor Yellow
}
 # Applications 

$Resource = "deviceAppManagement/mobileApps"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)?`$expand=Assignments"
$Apps = (Invoke-MgGraphRequest -Method GET -Uri $uri).Value | Where-Object {$_.assignments.target.groupId -match $Group.id}

Write-host "Following Apps has been assigned to: $($Group.DisplayName)" -ForegroundColor cyan
 
foreach ($App in $Apps) {

  Write-host "$($App.DisplayName)" -ForegroundColor Yellow
  

}

 # Application Configurations (App Configs)


$Resource = "deviceAppManagement/targetedManagedAppConfigurations"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)?`$expand=Assignments"
$AppConfigs = (Invoke-MgGraphRequest -Method GET -Uri $uri).Value | Where-Object {$_.assignments.target.groupId -match $Group.id}

Write-host "Following App Configuration has been assigned to: $($Group.DisplayName)" -ForegroundColor cyan
 
foreach ($AppConfig in $AppConfigs) {

  Write-host "$($AppConfig.DisplayName)" -ForegroundColor Yellow
  

}

## App protection policies


$AppProtURIs = @{
    iosManagedAppProtections = "https://graph.microsoft.com/beta/deviceAppManagement/iosManagedAppProtections?`$expand=Assignments"
    androidManagedAppProtections = "https://graph.microsoft.com/beta/deviceAppManagement/androidManagedAppProtections?`$expand=Assignments"
    windowsManagedAppProtections = "https://graph.microsoft.com/beta/deviceAppManagement/windowsManagedAppProtections?`$expand=Assignments"
    mdmWindowsInformationProtectionPolicies = "https://graph.microsoft.com/beta/deviceAppManagement/mdmWindowsInformationProtectionPolicies?`$expand=Assignments"
  }


$graphApiVersion = "Beta"

$AllAppProt = $null
foreach ($url in $AppProtURIs.GetEnumerator()) {


 $AllAppProt = (Invoke-MgGraphRequest -Method GET -Uri $url.value).Value | Where-Object {$_.assignments.target.groupId -match $Group.id} -ErrorAction SilentlyContinue
  Write-host "Following App Protection / "$($url.name)" has been assigned to: $($Group.DisplayName)" -ForegroundColor cyan
  foreach ($AppProt in $AllAppProt) {

    Write-host "$($AppProt.DisplayName)" -ForegroundColor Yellow
     
  }
  } 

# Device Configuration

$DCURIs = @{
    ConfigurationPolicies = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies?`$expand=Assignments"
    DeviceConfigurations = "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations?`$expand=Assignments"
    GroupPolicyConfigurations = "https://graph.microsoft.com/beta/deviceManagement/groupPolicyConfigurations?`$expand=Assignments"
    mobileAppConfigurations = "https://graph.microsoft.com/beta/deviceAppManagement/mobileAppConfigurations?`$expand=Assignments"
  }
  
$AllDC = $null
foreach ($url in $DCURIs.GetEnumerator()) {


  $AllDC = (Invoke-MgGraphRequest -Method GET -Uri $url.value).Value | Where-Object {$_.assignments.target.groupId -match $Group.id} -ErrorAction SilentlyContinue
  Write-host "Following Device Configuration / "$($url.name)" has been assigned to: $($Group.DisplayName)" -ForegroundColor cyan
  foreach ($DCs in $AllDC) {

    #If statement because ConfigurationPolicies does not contain DisplayName. 
      if ($($DCs.displayName -ne $null)) { 
      
      Write-host "$($DCs.DisplayName)" -ForegroundColor Yellow
      } 
      else {
        Write-host "$($DCs.Name)" -ForegroundColor Yellow
      } 
  }
  } 

### Remediation scripts 

$uri = "https://graph.microsoft.com/beta/deviceManagement/deviceHealthScripts"
$REMSC = Invoke-MgGraphRequest -Method GET -Uri $uri
$AllREMSC = $REMSC.value 
Write-host "Following Remediation Script has been assigned to: $($Group.DisplayName)" -ForegroundColor cyan
 
foreach ($Script in $AllREMSC) {

$SCRIPTAS = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceHealthScripts/$($Script.Id)/assignments").value 

  if ($SCRIPTAS.target.groupId -match $Group.Id) {
  Write-host "$($Script.DisplayName)" -ForegroundColor Yellow
  }

}


### Platform Scrips / Device Management 

$Resource = "deviceManagement/deviceManagementScripts"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/beta/deviceManagement/deviceManagementScripts"
$PSSC = Invoke-MgGraphRequest -Method GET -Uri $uri
$AllPSSC = $PSSC.value
Write-host "Following Platform Scripts / Device Management scripts has been assigned to: $($Group.DisplayName)" -ForegroundColor cyan

foreach ($Script in $AllPSSC) {
  
$SCRIPTAS = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/deviceManagementScripts/$($Script.Id)/assignments").value 

  if ($SCRIPTAS.target.groupId -match $Group.Id) {
  Write-host "$($Script.DisplayName)" -ForegroundColor Yellow
  }

}

### Windows Autopilot profiles

$Resource = "deviceManagement/windowsAutopilotDeploymentProfiles"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)?`$expand=Assignments"
$Response = Invoke-MgGraphRequest -Method GET -Uri $uri
$AllObjects = $Response.value
Write-host "Following Autopilot Profiles has been assigned to: $($Group.DisplayName)" -ForegroundColor cyan

foreach ($Script in $AllObjects) {
  
$APProfile = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/$($Script.Id)/assignments").value 

  if ($APProfile.target.groupId -match $Group.Id) {
  Write-host "$($Script.DisplayName)" -ForegroundColor Yellow
  }

}

Disconnect-Graph
