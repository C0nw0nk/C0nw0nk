
Set-ExecutionPolicy Bypass -Scope Process -Force;

# Enable TLSv1.2 for compatibility with older clients
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://gist.githubusercontent.com/C0nw0nk/e9143bce8e9306b5057ef6c7c9843c37/raw/597e6ec808d823eefc85c73613587042f8f5676b/batch_file_my_ip.cmd'

$name_with_ext = $DownloadURL -split '\/' | select -Last 1
$ext = $name_with_ext -split '\.' | select -Last 1
$name = $name_with_ext -split '\.' | select -First 1
$FilePath = "$env:TEMP\$name.$ext"
$ScriptArgs = "$args "

Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $FilePath -ErrorAction Stop

if (Test-Path $FilePath) {
    Start-Process $FilePath $ScriptArgs -Wait
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
}
