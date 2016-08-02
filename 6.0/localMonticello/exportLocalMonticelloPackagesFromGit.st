| bootstrappedPackages mcPackages pharoRepository targetRepository targetMCRepository |

bootstrappedPackages := #('AST-Core' 
    'Announcements-Core' 'CodeExport' 
    'CodeImport' 'CodeImportCommandLineHandlers' 'Collections-Abstract' 
    'Collections-Arithmetic' 'Collections-Atomic' 'Collections-Native' 
    'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams'
    'Collections-Strings' 'Collections-Support' 'Collections-Unordered' 
    'Collections-Weak'  'FileSystem-Core' 'FileSystem-Disk'
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
 'Compression'
 'Monticello'
 'Ring-Monticello'
 ).

pharoRepository := MCFileTreeRepository new
	directory: './pharo-core/src' asFileReference;
	yourself.	

targetRepository := MCDirectoryRepository new
	directory: './kernelPackages' asFileReference;
	yourself.
	
targetMCRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	

bootstrappedPackages do: [ :packageName |
  packageName logCr.
  targetRepository storeVersion: (pharoRepository loadVersionFromFileNamed: packageName, '.package')].	

mcPackages do: [ :packageName |
  packageName logCr.
  targetMCRepository storeVersion: (pharoRepository loadVersionFromFileNamed: packageName, '.package')].


	
	
    
  
  