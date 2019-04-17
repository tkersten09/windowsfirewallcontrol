$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = 'https://www.binisoft.org/download/wfc6setup.exe' 
  File          = "$toolsDir\wfcsetup.exe"
  silentArgs    = ''
  validExitCodes= @(0)
  softwareName  = 'Malwarebytes Windows Firewall Control*'
}

Get-ChocolateyWebFile @packageArgs

# Checks if WFC is already installed. If true, performs an update instead of a fresh installation.
# An update preserves the custom firwall rules of the existing installation.
[bool] $update = $False
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($key.Count -gt 1) {
    # If one or more Programs are installed starting with the softwareName as above,
    # then at least one of them is WFC. And an update is necessary.
    $update = $True
}

if ($update -eq $True) {
    Write-Verbose "[$($packageArgs['softwareName'])] Update WFC"
    Start-Process $toolsDir\wfcsetup.exe -Wait -Verb "runas" -ArgumentList '-u -c'
} else {
    Write-Verbose "[$($packageArgs['softwareName'])] Install WFC"
    Start-Process $toolsDir\wfcsetup.exe -Wait -Verb "runas" -ArgumentList '-i -c'
}


Remove-Item $toolsDir\*.exe -ea 0 -force
