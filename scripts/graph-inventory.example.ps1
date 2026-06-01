<#
.SYNOPSIS
    Example Microsoft Graph inventory script for the Entra ID security lab.

.DESCRIPTION
    This script connects to Microsoft Graph using delegated read-only permissions
    and exports basic Entra ID users and groups to local CSV files.

    This is a portfolio-safe example:
    - No tenant ID is hardcoded
    - No client secret is used
    - No token is stored
    - Output files are ignored by Git

.REQUIREMENTS
    Install the Microsoft Graph PowerShell module first:

    Install-Module Microsoft.Graph -Scope CurrentUser

.PERMISSIONS
    The script requests read-only scopes:

    User.Read.All
    Group.Read.All
    Directory.Read.All
#>

$ErrorActionPreference = "Stop"

$outputDir = Join-Path $PSScriptRoot "..\output"

if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan

Connect-MgGraph -Scopes "User.Read.All","Group.Read.All","Directory.Read.All" -NoWelcome

Write-Host "Exporting users..." -ForegroundColor Cyan

$users = Get-MgUser -All -Property DisplayName,UserPrincipalName,AccountEnabled,Id,CreatedDateTime |
    Select-Object DisplayName,UserPrincipalName,AccountEnabled,CreatedDateTime

$usersPath = Join-Path $outputDir "entra-users.csv"
$users | Export-Csv -Path $usersPath -NoTypeInformation -Encoding UTF8

Write-Host "Exporting groups..." -ForegroundColor Cyan

$groups = Get-MgGroup -All -Property DisplayName,Id,SecurityEnabled,MailEnabled,GroupTypes |
    Select-Object DisplayName,SecurityEnabled,MailEnabled,GroupTypes

$groupsPath = Join-Path $outputDir "entra-groups.csv"
$groups | Export-Csv -Path $groupsPath -NoTypeInformation -Encoding UTF8

Write-Host "Inventory export completed." -ForegroundColor Green
Write-Host "Users CSV:  $usersPath"
Write-Host "Groups CSV: $groupsPath"

Disconnect-MgGraph | Out-Null
