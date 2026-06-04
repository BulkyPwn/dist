$scriptDir = $PSScriptRoot
$fileName  = "AI_Assistant_Setup 1.0.0.exe"

# === Merge ===
$parts = Get-ChildItem (Join-Path $scriptDir "$fileName.part*") | Sort-Object Name
$outFile = Join-Path $scriptDir "AI_Assistant_Setup 1.0.0_reassembled.exe"
$outStream = [System.IO.File]::Create($outFile)
foreach ($part in $parts) {
    $data = [System.IO.File]::ReadAllBytes($part.FullName)
    $outStream.Write($data, 0, $data.Length)
    Write-Host "Merged: $($part.Name)"
}
$outStream.Close()
Write-Host "Merge done: $outFile"