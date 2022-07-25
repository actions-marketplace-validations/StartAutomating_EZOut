$EZOutLoaded = Get-Module EZOut
if (-not $EZOutLoaded) {
    $EZOutLoaded = Get-ChildItem -Recurse -Filter "*.psd1" | 
        Where-Object Name -eq 'EZOut.ps1' | 
        Import-Module -Name { $_.FullName } -Force -PassThru
}
if ($EZOutLoaded) {
    "::notice title=ModuleLoaded::EZOut Loaded" | Out-Host
} else {
    "::error:: EZOut not loaded" |Out-Host
}
if ($EZOutLoaded) {
    Save-MarkdownHelp -Module $EZOutLoaded.Name -PassThru -SkipCommandType Alias
}
