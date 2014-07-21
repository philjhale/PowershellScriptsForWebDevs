# Useful when Visual Studio doesn't remove all pdbs and dlls on rebuild. No idea why this happens but sometimes it does

# Navigate to the folder first. cd path to folder
gci -recurse -include @("*.dll", "*.pdb") | foreach ($_) { Remove-Item $_.FullName }