packageNames := #(
 'System-FileRegistry' 
 'FileSystem-Memory'
 'Regex-Core'
 'Ring-Core-Containers'
 'StartupPreferences'
 'ConfigurationCommandLineHandler-Core'
 'PragmaCollector'
 'Reflectivity'
 'System-FileRegistry'
 'MonticelloConfigurations'
 'Gofer-Core'
 'Metacello-Base'
 'Metacello-Core'
 'MonticelloFileTree-Core'
 'Metacello-MC'
 'Metacello-PharoCommonPlatform'
 'Metacello-Platform'
 'Metacello-ToolBox'
 'MonticelloFileTree-FileSystem-Utilities'
).

FileStream forceNewFileNamed: 'versions.txt' do: [:s |
  packageNames collect: [ :pacakgeName |
    s nextPutAll: (MCPackage named: pacakgeName) workingCopy ancestry ancestors first name; lf.]].
