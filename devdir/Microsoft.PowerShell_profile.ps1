$scriptname = & {$MyInvocation.ScriptName}
Write-Output "$scriptname is starting"
Write-Output "Jörgs powershell-profile under Docker version 20250820-a @ $profile"
Write-Output ""

Write-Output "DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=$env:DOTNET_SYSTEM_GLOBALIZATION_INVARIANT"
Write-Output "Current culture active="
Get-Culture | Format-List -Property *
Write-Output ""

# working from Home-Dir
Set-Location ~
Get-ChildItem -Attributes normal,hidden,directory

# show, check & preparing mountable dir content
$workdir = "~/workdir"
Get-ChildItem -Path "${workdir}"
Write-Output ""

$workfile = "$env:PWSHSCRIPTFILE"
if ([string]::IsNullOrEmpty($workfile)) {
    Write-Output "Environmentvariable PWSHSCRIPTFILE not set or empty. Setting workfile variable to default value JStandard.ps1"
    $workfile = "JStandard.ps1"
} else {
    Write-Output "Environmentvariable PWSHSCRIPTFILE is set und will be used. Setting workfile to $workfile"
}

$workfilepath = $workdir + "/" + $workfile
Write-Output "Workfilepath = $workfilepath"

# Look for existing mounted scriptfile and do not overwrite. Copy only if no scriptfile is existinf
if (Test-Path -Path $workfilepath -PathType Leaf) {
    Write-Output "Found existing $workfile in mounted $workdir - will not copy image default Script and start existing $workfile"
} elseif (Test-Path -Path "~/$workfile" -PathType Leaf) {
    Write-Output "No existing $workfile found in mounted $workdir , will copy standard image-file-version into $workdir and start $workfile afterwards"
    Write-Output "Execute = Copy-Item -Path `"~/$workfile`" -Destination `"$workfilepath`" "
    Copy-Item -Path "~/$workfile" -Destination "$workfilepath"
} else {
    Write-Output "No existing $workfile found in $workdir and no default version in image - exit script/container"
    exit 99
}

#finally run it only if there is no other pwsh-process already running
if ( (Get-Process | Where-Object Name -eq "pwsh").Count -le 1) {
    Write-Output "First pwsh instance is running. Start script $workfile in $workdir"
    Set-Location $workdir
    . ./$workfile
} else {
    Write-Output "This is NOT the first pwsh instance running. Will NOT start $workfile in $workdir"
}

Write-Output "$scriptname is ending"
