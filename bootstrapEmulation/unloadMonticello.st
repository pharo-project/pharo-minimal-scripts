MCPackageManager allSubInstancesDo: [:o | o  unregister].
SystemAnnouncer uniqueInstance unsubscribe: MCWorkingCopy!

| mcPackage classes |

"Smalltalk at: #ListOfMethods put: (SystemNavigation default allMethods collect: #asString). "

WeakArray restartFinalizationProcess.

mcPackage := 'Monticello' asPackage.
mcPackage extensionMethods do: #removeFromSystem.

classes := mcPackage classes.
classes do: #removeFromSystem.

mcPackage := 'Ring-Monticello' asPackage.
mcPackage extensionMethods do: #removeFromSystem.

classes := mcPackage classes.
classes do: #removeFromSystem.

SystemAnnouncer reset.
ChangesLog reset default. "subscribe to SystemAnnouncer"

WeakArray restartFinalizationProcess.

!

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 2:53:22.880903 pm'!

!RPackageOrganizer methodsFor: 'private registration' stamp: 'EstebanLorenzano 2/21/2014 12:56'!
basicRegisterPackage: aPackage
	"A new package is now available and declared in the receiver. Note that it is a low level implementation method since it does not deal with package contained information and does not update the related mapping tables."
	
	packages 
		at: aPackage name asSymbol 
		put: aPackage.
	"register mc package"
	"MCWorkingCopy forPackage: (MCPackage named: aPackage name)."
	
	^ aPackage! !



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
    
    
RPackageOrganizer default initializeFromPackagesList: packages.!

Smalltalk snapshot: true andQuit: true.
