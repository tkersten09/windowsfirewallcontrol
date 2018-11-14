$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = 'https://www.binisoft.org/download/wfc5setup.exe'
  checksum      = 'fe81a44112861276af83fdbcfe1a86bcd641df93781d016d9b5978830fd011ef'
  checksumType  = 'sha256' 
  File          = "$toolsDir\wfc5setup.exe"
  silentArgs   = ''
  validExitCodes= @(0)
}

Get-ChocolateyWebFile @packageArgs

Start-Process $toolsDir\wfc5setup.exe -Verb "runas"
Start-Process autohotkey -Wait -ArgumentList '.\install-windows-firewall-control.ahk' -WorkingDirectory $toolsDir
Remove-Item $toolsDir\*.exe -ea 0 -force
