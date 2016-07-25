| bootstrappedPackages mcPackages zincPackagesInPharoRepository zincPackages zodiacPackages pharoRepository zincRepository zodiacRepository targetRepository |

bootstrappedPackages := #('AST-Core' 
    'Announcements-Core' 'CodeExport' 
    'CodeImport' 'CodeImportCommandLineHandlers' 'Collections-Abstract' 
    'Collections-Arithmetic' 'Collections-Atomic' 'Collections-Native' 
    'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams'
    'Collections-Strings' 'Collections-Support' 'Collections-Unordered' 
    'Collections-Weak' 'Compression' 'FileSystem-Core' 'FileSystem-Disk'
    'Files' 'Jobs' 'Kernel' 'Multilingual-Encodings' 'Multilingual-Languages'
    'Multilingual-TextConversion' 'Network-UUID' 'OpalCompiler-Core' 'Random-Core' 'RPackage-Core' 
    'Ring-Core-Containers' 'Ring-Core-Kernel' 'RingChunkImporter'
    'Slot' "'System-Announcements' temporary remove" 'System-BasicCommandLineHandler' 'System-Changes' 
    'System-CommandLine' 'System-CommandLineHandler' 'System-Finalization'
    'System-Hashing' 'System-Localization' 'System-Model' 'System-Platforms' 
    'System-Sources' 'System-Support' 'Traits' 'Transcript' 'UIManager' 
    'Zinc-Character-Encoding-Core' 'Zinc-Resource-Meta-Core' 'NonInteractiveTranscript'
    
    'System-SessionManager'
    
    "'System-Object Events'").

mcPackages := #(
 'Monticello'
 'Ring-Monticello'
 ).

pharoRepository := MCHttpRepository
    location: 'http://smalltalkhub.com/mc/Pharo/Pharo60/main'
    user: ''
    password: ''.

targetRepository := MCDirectoryRepository new
	directory: './kernelPackages' asFileReference;
	yourself.
	
targetMCRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	

bootstrappedPackages do: [ :packageName |
  packageName logCr.
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].
	

mcPackages do: [ :packageName |
  packageName logCr.
  targetMCRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].
	
	
    
  
  