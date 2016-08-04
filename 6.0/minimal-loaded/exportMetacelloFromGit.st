
|  mcPackages pharoRepository targetRepository |

mcPackages := #(
 'Text-Core'
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
 'STON-Core'
 ).

pharoRepository := MCFileTreeRepository new
	directory: './pharo-core/src' asFileReference;
	yourself.	
    
targetRepository := MCDirectoryRepository new
	directory: './metacelloPackages' asFileReference;
	yourself.	
	
mcPackages do: [ :packageName |
  packageName logCr.
  targetRepository storeVersion: (pharoRepository loadVersionFromFileNamed: packageName, '.package')].	
	
	
    
  
  