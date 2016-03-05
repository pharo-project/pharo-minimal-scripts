	
| repository display loader |


MCMethodDefinition initializersEnabled: false.
    
DangerousClassNotifier disable.

repository := MCDirectoryRepository new
	directory: './miniPackages' asFileReference;
	yourself.
		
repository directory files sorted
	do: [ :each | | mcVersion |
	loader := MCVersionLoader new.	
		mcVersion := each basenameWithoutExtension.
		loader addVersion: (repository versionFrom: mcVersion).
		loader load. 
			].
Stdio stdout nextPutAll: 'load again...'; lf; flush.
					
	
MCMethodDefinition initializersEnabled: true.

display := (Smalltalk classNamed: #DisplayScreen) new.
display setExtent: (Smalltalk classNamed: #DisplayScreen) actualScreenSize depth: 2.
Smalltalk globals at: #Display put: display.
display beDisplay.

Cursor classPool at: #CurrentCursor put: Cursor new.
Cursor classPool at: #WebLinkCursor put: Cursor new.
			
Cursor initialize.
DisplayScreen initialize.
BitBlt initialize.
Color initialize.
IdentityTransform initialize.
InternetConfiguration initialize.
NetNameResolver initialize.
Socket initialize.
Base64MimeConverter initialize.
RxMatcher initialize.
RxParser initialize.
RxsPredicate initialize.
Clipboard initialize.
EventSensorConstants initialize.
TextConstants initialize.
Text initialize.
TextStyle initialize.

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
	
