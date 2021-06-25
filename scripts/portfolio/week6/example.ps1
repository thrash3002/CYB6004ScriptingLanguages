$number = Read-Host -Prompt "Please type a number greater than 5"

while( [int]$number -lt 5 )
{
	Write-Output "That number is less than 5.  Try again"
	$number = Read-Host -Prompt "Please type a number greater than 5"
}
Write-Output "Thank you"