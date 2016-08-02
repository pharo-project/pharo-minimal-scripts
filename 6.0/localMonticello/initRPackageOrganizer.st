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

	

'protocols.txt' asFileReference readStreamDo: [:stream |
  [stream atEnd] whileFalse: [
    | line |
    line := stream upTo: Character cr.
      items := line findTokens: String tab.
  items logCr.
  class := (items second = 'true') 
    ifTrue: [(Smalltalk classOrTraitNamed: items first) class]
    ifFalse: [Smalltalk classOrTraitNamed: items first].
  selector := items third asSymbol.
 
  (class localSelectors includes: selector)
    ifTrue: [class organization classify: selector under: items fourth]
    ifFalse: []..
  
]].


RPackageOrganizer default basicInitializeFromPackagesList: #(
    'Kernel' 'Collections-Strings' 'Collections-Weak'  'System-Support' 'Files'
    'AST-Core' 
    'Announcements-Core' 'CodeExport' 
    'CodeImport' 'CodeImportCommandLineHandlers' 'Collections-Abstract' 
    'Collections-Arithmetic' 'Collections-Atomic' 'Collections-Native' 
    'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams'
     'Collections-Support' 'Collections-Unordered' 
     'FileSystem-Core' 'FileSystem-Disk'
     'Jobs'   'Multilingual-Encodings' 'Multilingual-Languages'
    'Multilingual-TextConversion' 'Network-UUID' 'OpalCompiler-Core' 'Random-Core' 'RPackage-Core' 
    'Ring-Core-Containers' 'Ring-Core-Kernel' 'RingChunkImporter'
    'Slot' 'System-Announcements' 'System-BasicCommandLineHandler' 'System-Changes' 
    'System-CommandLine' 'System-CommandLineHandler' 'System-Finalization'
    'System-Hashing' 'System-Localization' 'System-Model' 'System-Platforms' 
    'System-Sources'  'Traits' 'Transcript' 'UIManager' 
    'Zinc-Character-Encoding-Core' 'Zinc-Resource-Meta-Core' 'NonInteractiveTranscript'
    'System-SessionManager'
    'PharoBootstrap-Initialization'
).
