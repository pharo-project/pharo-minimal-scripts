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
