
$cred = Get-Credential #Read credentials
 $username = $cred.username
 $password = $cred.GetNetworkCredential().password

 # Get current domain using logged-on user's credentials
 $CurrentDomain = "LDAP://" + ([ADSI]"").distinguishedName
 $domain = New-Object System.DirectoryServices.DirectoryEntry($CurrentDomain,$UserName,$Password)

if ($domain.name -eq $null)
{
 write-host "Authentication failed - please verify your username and password."
 exit #terminate the script.
}
else
{
 write-host "Successfully authenticated with domain $domain.name"
}

#import the Active Directory module in order to be able to use get-ADuser and Add-AdGroupMembe cmdlet

import-Module ActiveDirectory

# enter login name of the first user
$copy = Read-host "Enter username to copy from:"

# enter login name of the second user
$paste  = Read-host "Enter username to copy to:"

# copy-paste process. Get-ADuser membership     | then selecting membership                       | and add it to the second user
get-ADuser -identity $copy -properties memberof | select-object memberof -expandproperty memberof | Add-AdGroupMember -Members $paste

Write-Host "The Operation has been successully completed!"