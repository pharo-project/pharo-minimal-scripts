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
 'Zinc-Character-Encoding-Core'
 'Network-Kernel'
 'Network-MIME'
 'Network-Url'
 'Network-Protocols'
 'Zinc-FileSystem'
 'System-FileRegistry'
 'MonticelloConfigurations'
 'Gofer-Core'
 'MonticelloFileTree-Core'
 'MonticelloFileTree-FileSystem-Utilities'
 'MonticelloRemoteRepositories'
 'MonticelloMocks'
 'Metacello-Core' 
 'Metacello-Base'
 'Metacello-MC'
 'Metacello-PharoCommonPlatform'
 'Metacello-Platform'
 'Metacello-Platform.pharo30'
 'Metacello-ToolBox').

zincPackages := #(
  'Zinc-HTTP').

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

packageNames do: [ :packageName |
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zincPackages do: [ :packageName |
  targetRepository storeVersion: (zincRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zodiacPackages do: [ :packageName |
  targetRepository storeVersion: (zodiacRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

Smalltalk exitSuccess.