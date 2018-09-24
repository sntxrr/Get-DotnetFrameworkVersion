<#
.SYNOPSIS

Retrieves .NET version from the registry

.NOTES

	File Name   : Get-DotnetFrameworkVersion.ps1 
	Author      : sntxrr+github@gmail.com
	Requires    : PowerShell Version 2.0, Windows 2008 or greater 

.DESCRIPTION

The Get-DotnetFrameworkVersion script peeks into the registry to determine which version of .NET is installed

#> 
function Test-Key([string]$path, [string]$key){
	if(!(Test-Path $path)) { 
		return $false 
	}    
	if ((Get-ItemProperty $path).$key -eq $null) {
		return $false 
	}    
	return $true
}

function Get-Framework-Versions(){
	$installedFrameworks = @()
	if(Test-Key "HKLM:\Software\Microsoft\.NETFramework\Policy\v1.0" "3705") { $installedFrameworks += "1.0" }
    if(Test-Key "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v1.1.4322" "Install") { $installedFrameworks += "1.1" }
	if(Test-Key "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v2.0.50727" "Install") { $installedFrameworks += "2.0" }
	if(Test-Key "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v3.0\Setup" "InstallSuccess") { $installedFrameworks += "3.0" }
	if(Test-Key "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v3.5" "Install") { $installedFrameworks += "3.5" }
	if(Test-Key "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Client" "Install") { $installedFrameworks += "4.0c" }
	if(Test-Key "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full" "Install") { $installedFrameworks += "4.0" }
	if(Test-Key "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full" "Release") { $installedFrameworks += "4.5" }
	return $installedFrameworks
	} 
Get-Framework-Versions