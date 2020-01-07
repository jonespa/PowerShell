
$csvfile = Import-CSV C:\usr\BIN\CSVFile.csv
ForEach($csv in $csvfile) {
gpresult /user $csv.UserName /S $csv.ComputerName /X c:\usr\bin\gporesults\$csv.xml
}

$gporesultlist = (get-childitem c:\usr\bin\gporesults).fullname

foreach ($gporesult in $gporesultlist){

[xml]$xml = get-content $gporesult
$xml.rsop.userresults | select name | export-csv c:\usr\bin\usergporesults.csv -Append  
$xml.rsop.userresults.gpo | where {$_.isvalid -eq 'true'} | where {$_.accessdenied -eq 'false'} | select name | export-csv c:\usr\bin\usergporesults.csv -Append 

$xml.rsop.ComputerResults | select name | export-csv c:\usr\bin\compgporesults.csv -Append 
$xml.rsop.ComputerResults.gpo | where {$_.isvalid -eq 'true'} | where {$_.accessdenied -eq 'false'} | select name | export-csv c:\usr\bin\compgporesults.csv -Append 
}