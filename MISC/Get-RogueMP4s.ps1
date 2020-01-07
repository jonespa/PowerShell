Write-Host "This script will find all MP4 files and collect the data in a CSV."
Write-Host "Run this on 2012dc1 to point it at the O: drive. Hit Enter to continue." -ForegroundColor Red
Read-Host ""
Write-Host "Collecting MP4 files..."
$files = Get-ChildItem -LiteralPath "F:\data\fee" -Recurse -Filter "*.MP4" | Select-Object -Property BaseName, FullName, LastWriteTime
Write-Host "Done."
Write-Host ""
Write-Host "Building results files..."
foreach ($file in $files) {
    $owner = Get-Acl -Path $file.Fullname | Select-Object Owner
    [pscustomobject]@{Name = $file.BaseName ; FilePath = $file.FullName ; LastModified = $file.LastWriteTime ; Owner = $owner.split("\")[1]} | Export-Csv -Path C:\Temp\MP4s.csv -Append -NoTypeInformation
}

Write-Host "-- Done --"  -ForegroundColor Green
Write-Host "Results saved in C:\Temp\MP4s.csv"