<#
Since it was first written in 2011, EzOut has radically simplified writing types and format files in PowerShell.


You used to have to fight with the formatting XML.  Now, EZOut lets you write your formatting with a simple script.


An .EZFormat.ps1 file is a script that will generate the format and types files for a module.  It's named MODULE.EzFormat.ps1, and traditionally looks something like this:


#>
$moduleName = 'MyModule'
$ModuleRoot = "$home\Documents\WindowsPowerShell\Modules\$moduleName"

$formatting = @()
$formatting += Write-FormatView -TypeName "My.Custom.Type" -Property a,b,c
$formatting += Write-FormatView -TypeName "My.Other.Custom.Type" -Action {
    $data = $_
    if ($request -and $response) {
        "<h1>$($Data.Title)</h1>
        <h2>$($Data.Subtitle)</h2>
        $($data | Select -ExcludeProperty Title, Subtitle | Out-Html)
        "

    } else {
        $data | Select * | Out-String -Width 10kb
    }
}


$formatting |
    Out-FormatData |
    Set-Content "$moduleRoot\$ModuleName.Format.ps1xml"
<#

Writing the .ezformat file this way makes it easier to manage generating complex formatting.  Once you've created an .ezformat.ps1 file, you have to change your module to include your format file.
#>
@{
    ModuleVersion = '0.1'
    FormatsToProcess = 'MyModule.format.ps1xml'
}

<#

Almost every module [Start-Automating](http://start-automating) produces has an ezformat.ps1 file.  You can find all of the .ezformat files on your system with this one liner:
#>

Get-ChildItem $home\Documents\WindowsPowerShell\Modules -recurse -Filter *.ezformat.ps1
