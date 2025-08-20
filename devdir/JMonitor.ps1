<#
    .SYNOPSIS
    Sends a cascade of <n> ICMP/Ping requests to a set of servers in an endless loop.
    
    .DESCRIPTION
    Sends a cascade of <n> ICMP/Ping requests to a set of servers in an endless loop.
    Can be stopped only via signaling (CTRL-C in a console, kill in Linux when in background/nohup mode)
    Writes timestamp and the average latency of the n requests into a logfile for further processing.
    Use corresponding Excel file "Pinger.xlsx" for a visualization of the results
    
	.EXAMPLE
	JMonitor
	Starts endless ping-loop with a default sleeptime of 57000 milliseconds ~ 1 minute and default numpings of 4

    .EXAMPLE
    JMonitor -sleeptime 7000 -numpings 4
    Starts an endless ping-loop with a sleeptime of 7000 milliseconds and 4 pings per address per cascade
		 
    .LINK
	https://wesemaenner.wordpress.com
	
  #>

 param(
    [switch]$help=$false,
    [Parameter(Mandatory=$false)][ValidateRange(1000,120000)][int]$sleeptime = 57000,
    [Parameter(Mandatory=$false)][ValidateRange(1,10)][int]$numpings = 4
)

# My own process
$me = $MyInvocation.MyCommand.Name
$version = "20250820-a"

 # show syntax
 if ($help) {
    
    Write-Output "Usage : $me [-numpings <int>] [-sleeptime <milliseconds>] [-help] [-debug] [-verbose] [OtherCommonParameters]"
    Write-Output "numpings=$numpings , sleeptime=$sleeptime , Debug=$DebugPreference , Verbose=$VerbosePreference"
    Write-Verbose "CommonParameter::Verbose was set "
    Write-Debug "CommonParameter::Debug was set"
    
    exit 0
}

# global variables besides in switches/arguments
$stopfile = Split-Path $MyInvocation.MyCommand.Name -LeafBase
$csvfile = $stopfile + ".csv" 
$stopfile = $stopfile + ".stop"

Write-Output "$me started in Version $version"
Write-Output "numpings=$numpings , sleeptime=$sleeptime , Debug=$DebugPreference , Verbose=$VerbosePreference"

if (Test-Path -Path $stopfile -PathType Leaf) {
    Write-Output "Found STOP-File $stopfile. Aborting Program before first loop"
    exit 98
} else {
    Write-Output "No STOP-File ($stopfile) found - continue"    
}

filter timestamp {"$(Get-Date -Format "dd.MM.yyyy HH:mm:ss") ,  $_"}
function onepingcascade($dest) {
    #$args
    $ping = Test-Connection -ComputerName $dest -count $numpings
    #$ping

    $i=0
    $sum=0
    $average=0
    foreach($p in $ping){
        $i=$i+1
        $sum=$sum+$p.Latency
        #$p
        <# if($p.Latency -gt 25){
            $p.reply.Address.IPAddressToString + ": " + $p.Latency +"ms"
        }
        #>   
    }
    
    $average=$sum/$i
    Write-Output "sum=$sum  ,  average=$average  ,  count=$i" | timestamp
}

while ($true) {
    #$ret = onepingcascade("www.web.de","www.msn.com")
    $ret = onepingcascade("82.165.229.138")
    $ret
    $ret | Out-File $csvfile -Append
    if (Test-Path -Path $stopfile -PathType Leaf) {
        Write-Output "Found STOP-File $stopfile. Aborting currently running program loop"
        exit 99
    }
    Start-Sleep -Milliseconds $sleeptime
}




