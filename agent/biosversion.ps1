$userHome = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)
$exePath = "$userHome\hp-cmsl-1.6.10.exe"
$xml=""
try {
    # Run a command or operation that might produce an error
    $updates = Get-HPBIOSUpdates -ErrorAction Stop
}
catch {
    # If an error occurs, you can handle it here
    # URL of the executable file
    $url = "https://hpia.hpcloud.hp.com/downloads/cmsl/hp-cmsl-1.6.10.exe"
    # Path where you want to save the downloaded exe file
    if (!Test-path $exePath) {
        
    }
    else{
        # Use Invoke-WebRequest to download the file
        Invoke-WebRequest -Uri $url -OutFile $exePath
    }
    # Check if the file exists
    if (Test-Path $exePath) {
        # Use Start-Process to run the executable with arguments
        Start-Process -FilePath $exePath -ArgumentList "/VERYSILENT"
    }
}
try {
    $updates = Get-HPBIOSUpdates -ErrorAction Stop
}
catch {
    $xml += "<BIOSVERSION>`n"
    $xml += "<INSTALLEDBIOSVERSION>" + '' + "</INSTALLEDBIOSVERSION>`n"
    $xml += "<INSTALLEDBIOSDATE>" + '' + "</INSTALLEDBIOSDATE>`n"
    $xml += "<LATESTBIOSVERSION>" + '' + "</LATESTBIOSVERSION>`n"
    $xml += "<LATESTBIOSDATE>" + '' + "</LATESTBIOSDATE>`n"
    $xml += "<ISREQUIREUPDATE>" + '' + "</ISREQUIREUPDATE>`n"
    $xml += "<INSTALLSTATUS>" + 'Error' + "</INSTALLSTATUS>`n"
    $xml += "</BIOSVERSION>`n"
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    [Console]::WriteLine($xml)
    exit
}
$updates = Get-HPBIOSUpdates
$latest_version = $updates[0] | Select-Object -ExpandProperty Ver
$latest_version = [version]$latest_version
$latest_date = $updates[0] | Select-Object -ExpandProperty Date
$latest_date = $latest_date.Replace("-", "")
$latest_date = [DateTime]::ParseExact($latest_date , "yyyyMMdd", $null)
$installed_version_info = wmic bios get Caption
$installed_version = [regex]::Match($installed_version_info, '\d+\.\d+\.\d+').Value
$installed_version = [version]$installed_version
$installed_date = wmic bios get ReleaseDate
$installed_date = [regex]::Match($installed_date , '\d{8}')
$installed_date = [DateTime]::ParseExact($installed_date, "yyyyMMdd", $null)
if ($latest_version -eq $installed_version -and $latest_date -eq $installed_date) {
    $update_required = $false
}
else {
    $update_required = $true
}
$xml += "<BIOSVERSION>`n"
$xml += "<INSTALLEDBIOSVERSION>" + $installed_version + "</INSTALLEDBIOSVERSION>`n"
$xml += "<INSTALLEDBIOSDATE>" + $installed_date + "</INSTALLEDBIOSDATE>`n"
$xml += "<LATESTBIOSVERSION>" + $latest_version.ToString() + "</LATESTBIOSVERSION>`n"
$xml += "<LATESTBIOSDATE>" + $latest_date + "</LATESTBIOSDATE>`n"
$xml += "<ISREQUIREUPDATE>" + $update_required.ToString() + "</ISREQUIREUPDATE>`n"
$xml += "<INSTALLSTATUS>" + 'True' + "</INSTALLSTATUS>`n"
$xml += "</BIOSVERSION>`n"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)
