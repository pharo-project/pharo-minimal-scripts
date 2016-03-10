packageNames := #(
 'Graphics-Display Objects'
 'Graphics-Primitives' 
 'Graphics-Transformations' 
 'System-Clipboard' 
 'System-FileRegistry' 
 'System-Object Events' 
 'Text-Core' 
 'FileSystem-Memory'
 'Regex-Core'
 'Ring-Core-Containers'
 'StartupPreferences'
 'ConfigurationCommandLineHandler-Core'
 'PragmaCollector'
 'System-VMEvents'
 'Reflectivity'
 'Network-Kernel'
 'Network-MIME'
 'Network-Url'
 'Network-Protocols'
 'System-FileRegistry'
 'MonticelloConfigurations'
 'Gofer-Core'
 'MonticelloFileTree-Core'
 'MonticelloRemoteRepositories'
 'MonticelloMocks'
 
 'Metacello-MC'
 'Metacello-Platform'
).
 
mcPackages := #(
  'MonticelloFileTree-FileSystem-Utilities'
).

metacelloPackages := #(
 'Metacello-Core' 
 'Metacello-Base'
 'Metacello-PharoCommonPlatform'
 'Metacello-ToolBox'
).

zincPackages := #(
  'Zinc-HTTP' 'Zinc-Character-Encoding-Core'  'Zinc-FileSystem').

zodiacPackages := #(
  'Zodiac-Core' ).

pharoRepository := MCHttpRepository
    location: 'http://smalltalkhub.com/mc/Pharo/Pharo50/main'
    user: ''
    password: ''.

zincRepository := MCHttpRepository
	location: 'http://mc.stfx.eu/ZincHTTPComponents'
	user: ''
	password: ''.

zodiacRepository := MCHttpRepository
	location: 'http://mc.stfx.eu/Zodiac'
	user: ''
	password: ''.
	
targetRepository := MCDirectoryRepository new
	directory: './miniPackages' asFileReference;
	yourself.
	
mcRepository := MCFileTreeRepository new
	directory: './filetree/repository' asFileReference;
	yourself.	
	
metacelloRepository := MCFileTreeRepository new
	directory: './pharo-metacello/repository' asFileReference;
	yourself.	

packageNames do: [ :packageName |
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zincPackages do: [ :packageName |
  targetRepository storeVersion: (zincRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zodiacPackages do: [ :packageName |
  targetRepository storeVersion: (zodiacRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

mcPackages do: [ :packageName |
  targetRepository storeVersion: ("mcRepository" pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

metacelloPackages do: [ :packageName |
  targetRepository storeVersion: (metacelloRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].
  
Smalltalk exitSuccess.
