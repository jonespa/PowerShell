## Script to find all subfolders in the scipt location and create an individual zip file for each.


$A = get-childitem | where {$_.PSiscontainer} 
$c = get-location

foreach ($b in $a) {
$fullname = $b.fullname
$name = $b.name
compress-archive -path $fullname -destinationpath $c\$name.zip
}