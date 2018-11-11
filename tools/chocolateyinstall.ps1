$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.binisoft.org/download/wfc5setup.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = $url

  checksum      = 'fe81a44112861276af83fdbcfe1a86bcd641df93781d016d9b5978830fd011ef'
  checksumType  = 'sha256'
  
  silentArgs   = ''
  validExitCodes= @(0)
}

Get-ChocolateyWebFile $packageName -url $url -FileFullPath $toolsDir\wfc5setup.exe -checksum $packageArgs['checksum'] -checksumType $packageArgs['checksumType']

Start-Process $toolsDir\wfc5setup.exe
Start-Process autohotkey -Wait -ArgumentList '.\install-windows-firewall-control.ahk' -WorkingDirectory $toolsDir
Remove-Item $toolsDir\*.exe -ea 0 -force
