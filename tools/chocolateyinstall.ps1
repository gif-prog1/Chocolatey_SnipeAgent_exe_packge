$packageName = 'snipeagent'
$url = 'http://192.168.3.15:88/SnipeAgent1.zip'
$zipDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$extractedDir = Join-Path $zipDir "$packageName"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $extractedDir
  fileType       = 'zip'
  url            = $url
}

Install-ChocolateyZipPackage @packageArgs

$exePath = Get-ChildItem $extractedDir -Filter "*.exe" | Select-Object -ExpandProperty FullName

if ($exePath) {
  Install-ChocolateyInstallPackage -PackageName $packageName -FileType 'exe' -SilentArgs '/S' -File "$exePath"
} else {
  Write-Error "Failed to find .exe file in the extracted directory."
}