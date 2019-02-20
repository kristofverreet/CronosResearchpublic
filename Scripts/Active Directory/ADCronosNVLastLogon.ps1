<#
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  This scripts lists all the inactive user accounts of an OU (example: Cronos NV)
    Inactive can be defined via a variable (example: 30 days)

.INPUTS
  [Int]InactivityDuration = number of days of inactivity
.OUTPUTS
  CSV File in $ScriptPath + "\CSVResults\"
.NOTES
  Version:        1.0
  Author:         Verreet Kristof
  Creation Date:  18/02/2019
  Purpose/Change: Initial script development
  
#>

#----------------------------------------------------------[Imports]----------------------------------------------------------

Import-Module ActiveDirectory -Cmdlet Get-AdUser , Search-ADAccount

$ScriptPath = $PSScriptRoot
$location =  $ScriptPath + "\CSVResults\" +"Results.csv"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

$InactivityDuration = 30

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function ListInactiveADAccounts (){

    param(
    [parameter(Mandatory=$true)]
    [int]
    $InactivityDuration
    )


Search-ADAccount -UsersOnly -SearchBase "OU=Cronos NV,OU=De Cronos Groep NV,OU=Nuclys NV,OU=Users,OU=Iconos,DC=Iconos,DC=be" -AccountInactive -TimeSpan "$InactivityDuration" | Get-ADUser -Properties Name | Select-Object Name |Export-Csv $location 

}

