$1 = 'Risk & Assurance'
$2 = 'Risk and Assurance'
$2 = $1 -replace 'and','&'
$3 = Read-Host "What is your Department Name?"
$4 = $3 -replace 'and','&'
Write-Host $4
