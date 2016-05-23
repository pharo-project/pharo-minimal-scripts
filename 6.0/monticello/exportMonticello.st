| bootstrappedPackages mcPackages zincPackagesInPharoRepository zincPackages zodiacPackages pharoRepository zincRepository zodiacRepository targetRepository |

bootstrappedPackages := #('AST-Core' 
    'Announcements-Core' 'CodeExport' 
    'CodeImport' 'CodeImportCommandLineHandlers' 'Collections-Abstract' 
    'Collections-Arithmetic' 'Collections-Atomic' 'Collections-Native' 
    'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams'
    'Collections-Strings' 'Collections-Support' 'Collections-Unordered' 
    'Collections-Weak' 'Compression' 'FileSystem-Core' 'FileSystem-Disk'
    'Files' 'Jobs' 'Kernel' 'Monticello' 'Multilingual-Encodings' 'Multilingual-Languages'
    'Multilingual-TextConversion' 'Network-UUID' 'OpalCompiler-Core' 'Random-Core' 'RPackage-Core' 
    'Ring-Core-Containers' 'Ring-Core-Kernel' 'Ring-Monticello' 'RingChunkImporter'
    'Slot' 'System-Announcements' 'System-BasicCommandLineHandler' 'System-Changes' 
    'System-CommandLine' 'System-CommandLineHandler' 'System-Finalization'
    'System-Hashing' 'System-Localization' 'System-Model' 'System-Platforms' 
    'System-Sources' 'System-Support' 'Traits' 'Transcript' 'UIManager' 
    'Zinc-Character-Encoding-Core' 'Zinc-Resource-Meta-Core' 'NonInteractiveTranscript'
    
    'AST-FFI-Pharo50Compatibility'
    'System-SessionManager'
    'PragmaCollector'
    
    "'System-Object Events'").

mcPackages := #(
 'Network-Kernel'
 'Network-MIME'
 'Network-Url'
 "'Network-Protocols'"
 'MonticelloRemoteRepositories' ).

zincPackagesInPharoRepository := #(
  'Zinc-Character-Encoding-Core').

zincPackages := #(
  'Zinc-HTTP' 'Zinc-FileSystem').
  
zodiacPackages := #(
  'Zodiac-Core' ).

pharoRepository := MCHttpRepository
    location: 'http://smalltalkhub.com/mc/Pharo/Pharo60/main'
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
	directory: './mcPackages' asFileReference;
	yourself.	
	
mcPackages do: [ :packageName |
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].
	
zincPackagesInPharoRepository do: [ :packageName |
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zincPackages do: [ :packageName |
  targetRepository storeVersion: (zincRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zodiacPackages do: [ :packageName |
  targetRepository storeVersion: (zodiacRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

bootstrappedPackages do: [ :packageName |
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].
	
	
    
  
  