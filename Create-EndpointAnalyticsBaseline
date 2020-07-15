$tenant = “viacompany.onmicrosoft.com”
$authority = “https://login.windows.net/$tenant”
$clientId = Get-AutomationVariable -Name 'ClientID'
$clientSecret = Get-AutomationVariable -Name 'ClientSecret'
 
 
 
$Resource = "deviceManagement/userExperienceAnalyticsBaselines"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($resource)"
$CurrentMonth = (Get-UICulture).DateTimeFormat.GetMonthName((Get-Date).Month)
 
 
 
Update-MSGraphEnvironment -AppId $clientId -Quiet
Update-MSGraphEnvironment -AuthUrl $authority -Quiet
Connect-MSGraph -ClientSecret $ClientSecret -Quiet
 
$JSONName = @"
{
"displayName":"$($CurrentMonth)"
}
"@
 
Invoke-MSGraphRequest -HttpMethod POST -Url $uri -Content $JSONName | out-null
