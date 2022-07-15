<#
Example script using the JumpCloud PowerShell module to search for macOS devices that do not have the JumpCloud service account that have been active in the last X days.

The variable $ActiveInLast_X_Days is by default set to 30. This value can be modified
#>

#---Editable Variables-----

[Int]$ActiveInLast_X_Days = '30'

#------DO NOT MODIFY BELOW------

$SearchParams_InactiveSystems = @{
    OS = 'Mac OS X'
    filterDateProperty = 'lastContact'
    dateFilter = 'after'
    date = "$($(Get-Date).AddDays(-($ActiveInLast_X_Days)))"
}

$SearchParams_ActiveSystems = @{
    OS = 'Mac OS X'
    active = $true
}

#Search for inactive systems with contact in last X days
$SearchResults = Get-JCSystem @SearchParams_InactiveSystems

#Search for active systems
$SearchResults += Get-JCSystem @SearchParams_ActiveSystems

#Search for device without the service Account

$SearchResults | Where-Object hasServiceAccount -EQ $false | Select-Object hostname, _id, hasServiceAccount, lastContact