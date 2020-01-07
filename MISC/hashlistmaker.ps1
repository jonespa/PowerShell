$given = get-aduser -filter * | ft givenname > c:\users\odonir\desktop\givenname.txt
$sur = get-aduser -filter * | ft surname | out-file c:\users\odonir\desktop\givenname.txt -append
$file = get-content c:\users\odonir\desktop\givenname.txt
$i = 1

$file = $file.trim() -ne ""
$file | out-file c:\users\odonir\desktop\givenname.txt


While ($i -lt 25)
{
foreach ($new1 in $file)
	{ 
	$new1 = $new1+$i | out-file c:\users\odonir\desktop\givenname.txt -append
	}
$i = $i+1
}
