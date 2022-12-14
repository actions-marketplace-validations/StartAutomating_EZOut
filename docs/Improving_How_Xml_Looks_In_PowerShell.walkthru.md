# Another view we can improve is the way that XML is rendered in PowerShell
[xml]"<a an='anattribute'><b d='attribute'><c/></b></a>"        

# It's not very intuitive.  
# I cannot really only see the element I am looking at, instead of a chunk of data

# Create a quick view for any XML element.  
# Piping it into Out-FormatData will make one or more format views into a full format XML file
# Piping the output of that into Add-FormatData will create a temporary module to hold the formatting data
# There's also a Remove-FormatData and 
Write-FormatView -TypeName "System.Xml.XmlNode" -Wrap -Property "Xml" -VirtualProperty @{
    "Xml" = { 
        $strWrite = New-Object IO.StringWriter
        ([xml]$_.Outerxml).Save($strWrite)
        "$strWrite"
    }
} | 
    Out-FormatData |
    Add-FormatData

# Now let's take a look at how the xml renders
[xml]"<a an='anattribute'><b d='attribute'><c /></b></a>"

# In case we want to go back to the original formatter, we can remove the formatter
# without giving the formatter a name, the 
Remove-FormatData -Name "System.Xml.XmlNode"

# And we're back to the original formatting
[xml]"<a an='anattribute'><b d='attribute'><c/></b></a>"
