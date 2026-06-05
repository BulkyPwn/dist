$scriptDir = $PSScriptRoot
$fileName  = "AI_Assistant Setup 1.0.0.exe"
$file      = Join-Path $scriptDir $fileName
$chunkSize = 100MB

# === Split ===
$stream = [System.IO.File]::OpenRead($file)
$buffer = New-Object byte[] $chunkSize
$index = 0
while ($bytesRead = $stream.Read($buffer, 0, $chunkSize)) {
    $chunk = New-Object byte[] $bytesRead
    [Array]::Copy($buffer, $chunk, $bytesRead)
    $partName = Join-Path $scriptDir "$fileName.part$($index.ToString('0000'))"
    [System.IO.File]::WriteAllBytes($partName, $chunk)
    Write-Host "Created: $partName ($bytesRead bytes)"
    $index++
}
$stream.Close()
Write-Host "Split done, total: $index parts"
