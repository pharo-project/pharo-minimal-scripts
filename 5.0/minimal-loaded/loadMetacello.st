

	
| repository display loader packages |



Smalltalk image recompile.

MCMethodDefinition initializersEnabled: false.
    
DangerousClassNotifier disable.

packages := #('AST-Core' 
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
    
    
RPackageOrganizer default initializeFromPackagesList: packages.

packages do: [:packageName |
  (MCWorkingCopy forPackage: (MCPackage named: packageName)).
  (MCVersion package: (MCPackage named: packageName))].

repository := MCDirectoryRepository new
	directory: './miniPackages' asFileReference;
	yourself.


repository directory files sorted
	do: [ :each | | mcVersion |
	
loader := MCVersionLoader new.	
		mcVersion := each basenameWithoutExtension.
	Stdio stdout nextPutAll: mcVersion asString; lf; flush.
		loader addVersion: (repository versionFrom: mcVersion).
		loader load.		
			].
			

repository directory files sorted
	do: [ :each | | mcVersion |
	
loader := MCVersionLoader new.	
		mcVersion := each basenameWithoutExtension.
	Stdio stdout nextPutAll: mcVersion asString; lf; flush.
		loader addVersion: (repository versionFrom: mcVersion).
		loader load.		
			].			
		
	
loader := MCVersionMerger new.
repository directory files sorted
	do: [ :each | | mcVersion |
	
		mcVersion := each basenameWithoutExtension.
	Stdio stdout nextPutAll: mcVersion asString; lf; flush.
		loader addVersion: (repository versionFrom: mcVersion).
				
			].
		
[loader merge] on: MCMergeResolutionRequest do: [:request |
  Stdio stdout << (request) asString; lf; flush.
  request autoMerge ].

  
  

Stdio stdout nextPutAll: 'merged'; lf; flush.
Stdio stdout nextPutAll: (Smalltalk classNamed: #MetacelloPlatform) asString; lf; flush.



	
MCMethodDefinition initializersEnabled: true.

".
display := (Smalltalk classNamed: #DisplayScreen) new.
display setExtent: (Smalltalk classNamed: #DisplayScreen) actualScreenSize depth: 2.
Smalltalk globals at: #Display put: display.
display beDisplay.
"

"
Stdio stdout nextPutAll: '#CurrentCursor'; lf; flush.

Cursor classPool at: #CurrentCursor put: Cursor new.
Cursor classPool at: #WebLinkCursor put: Cursor new.
			
Cursor initialize.
DisplayScreen initialize.
BitBlt initialize.
Color initialize.
"

IdentityTransform initialize.
InternetConfiguration initialize.
NetNameResolver initialize.
Socket initialize.
Base64MimeConverter initialize.
RxMatcher initialize.
RxParser initialize.
RxsPredicate initialize.
Clipboard initialize.
"EventSensorConstants initialize."

"TextConstants initialize.
Text initialize.
TextStyle initialize."

ZnBase64Encoder initialize.
ZnByteEncoder initialize.
ZnUTF8Encoder initialize.
ZnLogEvent initialize.
ZnConstants initialize.
ZnHeaders initialize.
ZnNetworkingUtils initialize.
ZnServer initialize.
ZnSingleThreadedServer initialize.

MCFileTreeStCypressWriter initialize.
MCFileTreeFileSystemUtils initialize.
MCMockASubclass initialize.
MCMockClassA initialize.

MetacelloPlatform initialize.
MetacelloPharoPlatform initialize.
MetacelloPharo30Platform initialize.



Stdio stdout nextPutAll: (ZnClient new get: 'http://zn.stfx.eu/zn/numbers.txt').

Smalltalk snapshot: true andQuit: true.
	
