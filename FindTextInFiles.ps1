# Find all any files containing "Meta". Show full path, line number and line 
Get-ChildItem -recurse -include *.* | Select-String "Meta"

# Find any .asp or .cs containing "Meta" using gci, Get-ChildItem alias. Only show file path
gci -recurse -include @("*.asp", "*.cs") | select-string "Meta" | select-object -Unique Path