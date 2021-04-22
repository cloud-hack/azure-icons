$base = New-Item -ItemType Directory -Path ~/Documents/AzureArcIcons -Force
New-Item -ItemType Directory -Path "$($base.FullName)/All" -Force | Out-Null
$svgs = Get-ChildItem ~/Downloads/Azure_Public_Service_Icons/Icons/ -Recurse
# Create new folder structure
$svgs | Select-Object Directory -Unique | ForEach-Object {
  $fldr = $_.Directory.Name
  if($fldr -notmatch "^Azure") {$fldr = "Azure {0}" -f $fldr}
  Get-ChildItem -Path $_.Directory.FullName -Filter *.svg  | ForEach-Object {
    $name = $_.Name
    $name = ($_.Name -split "-icon-service-")[1] -replace "-", " "
    if($name -notmatch "^Azure") {$name = "Azure {0}" -f $name}
    New-Item -ItemType Directory -Path "$($base.FullName)/$fldr" -Force | Out-Null
    Copy-Item -Path $_.FullName -Destination "$($base.FullName)/$fldr/$name" -Force
    Copy-Item -Path $_.FullName -Destination "$($base.FullName)/All/$name" -Force
  }
}
