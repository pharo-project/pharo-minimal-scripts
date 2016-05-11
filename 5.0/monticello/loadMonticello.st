'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 1:36:00.128099 pm'!

!RPackageOrganizer methodsFor: 'private registration' stamp: 'EstebanLorenzano 2/21/2014 12:56'!
basicRegisterPackage: aPackage
	"A new package is now available and declared in the receiver. Note that it is a low level implementation method since it does not deal with package contained information and does not update the related mapping tables."
	
	packages 
		at: aPackage name asSymbol 
		put: aPackage.
	"register mc package"
	MCWorkingCopy forPackage: (MCPackage named: aPackage name).
	
	^ aPackage! !

!

'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 3:35:27.377099 pm'!

!RPackageOrganizer class methodsFor: 'singleton' stamp: 'StephaneDucasse 6/3/2012 22:39'!
resetDefault

	"self resetDefault"
	default  ifNotNil: [
		"When an Organizer is not used anymore, we should always pay attention that these two actions are corretly done."
		default unregisterInterestToSystemAnnouncement.
		MCWorkingCopy removeDependent: default].
	default := self new.
	self packageClass initialize! !


'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 3:35:38.129822 pm'!

!RPackageOrganizer methodsFor: 'private' stamp: 'CamilleTeruel 7/29/2012 18:47'!
stopNotification
	"(self instVarNamed: #default) stopNotification"
	
	"pay attention that we can break the system using this method"
	
	SystemAnnouncer uniqueInstance unsubscribe: self.
	MCWorkingCopy removeDependent: self.! !
	
'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 11 May 2016 at 8:59:11.695352 am'!

!Object class methodsFor: '*System-Object Events' stamp: 'rw 2/10/2002 13:09'!
flushEvents
	"EventManager removed"

	! !
	
	
'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 3:36:09.623307 pm'!

!RPackageOrganizer methodsFor: 'system integration' stamp: 'BernardoContreras 10/24/2014 17:36'!
registerInterestToAnnouncer: anAnnouncer	
	"There should be only one"
	anAnnouncer unsubscribe: self.
	
	anAnnouncer weak
		when: CategoryAdded send: #systemCategoryAddedActionFrom: to: self;
		when: CategoryRemoved send: #systemCategoryRemovedActionFrom: to: self;
		when: CategoryRenamed send: #systemCategoryRenamedActionFrom: to: self;
		when:  ClassAdded send: #systemClassAddedActionFrom: to: self;
		when:  ClassRecategorized send: #systemClassRecategorizedActionFrom: to: self;
		when:  ClassRemoved send: #systemClassRemovedActionFrom: to: self;
		when:  ClassRenamed send: #systemClassRenamedActionFrom: to: self;
		when:  ClassReorganized send: #systemClassReorganizedActionFrom: to: self;
		when:  MethodAdded send: #systemMethodAddedActionFrom: to: self;
		when:  MethodModified send: #systemMethodModifiedActionFrom: to: self;
		when:  MethodRecategorized send: #systemMethodRecategorizedActionFrom: to: self;
		when:  MethodRemoved send: #systemMethodRemovedActionFrom: to: self;
		when:  ProtocolAdded send: #systemProtocolAddedActionFrom: to: self;
		when:  ProtocolRemoved send: #systemProtocolRemovedActionFrom: to: self.
		
	self flag: #hack. "for decoupling MC"
	#MCWorkingCopy asClassIfPresent: [ 
		anAnnouncer weak
			when: (Smalltalk globals at: #MCWorkingCopyCreated) 
				send: #updateAfterNewMCPackageRegistred: 
				to: self;
			when: (Smalltalk globals at: #MCWorkingCopyDeleted) 
				send: #updateAfterNewMCPackageUnregistred: 
				to: self	].! !

				
				
| packages pharoRepository |
				
SystemAnnouncer restoreAllNotifications.


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
    
    'Monticello' 'Ring-Monticello' 
    
    "'System-Object Events'").
    
versions := #('AST-Core-TheIntegrator.418' 'Announcements-Core-TheIntegrator.68' 'CodeExport-TheIntegrator.19' 'CodeImport-TheIntegrator.88' 'CodeImportCommandLineHandlers-TheIntegrator.7' 'Collections-Abstract-TheIntegrator.313' 'Collections-Arithmetic-TheIntegrator.20' 'Collections-Atomic-TheIntegrator.16' 'Collections-Native-TheIntegrator.19' 'Collections-Sequenceable-TheIntegrator.243' 'Collections-Stack-TheIntegrator.10' 'Collections-Streams-TheIntegrator.188' 'Collections-Strings-TheIntegrator.415' 'Collections-Support-TheIntegrator.67' 'Collections-Unordered-TheIntegrator.232' 'Collections-Weak-TheIntegrator.102' 'Compression-TheIntegrator.176' 'FileSystem-Core-TheIntegrator.202' 'FileSystem-Disk-TheIntegrator.97' 'Files-TheIntegrator.417' 'Jobs-TheIntegrator.28' 'Kernel-TheIntegrator.2290' 'Monticello-TheIntegrator.1132' 'Multilingual-Encodings-TheIntegrator.61' 'Multilingual-Languages-TheIntegrator.55' 'Multilingual-TextConversion-TheIntegrator.81' 'Network-UUID-TheIntegrator.44' 'OpalCompiler-Core-TheIntegrator.799' 'Random-Core-TheIntegrator.4' 'RPackage-Core-TheIntegrator.430' 'Ring-Core-Containers-TheIntegrator.45' 'Ring-Core-Kernel-TheIntegrator.237' 'Ring-Monticello-TheIntegrator.43' 'RingChunkImporter-TheIntegrator.8' 'Slot-TheIntegrator.742' 'System-Announcements-TheIntegrator.108' 'System-BasicCommandLineHandler-TheIntegrator.18' 'System-Changes-TheIntegrator.292' 'System-CommandLine-TheIntegrator.181' 'System-CommandLineHandler-TheIntegrator.18' 'System-Finalization-TheIntegrator.32' 'System-Hashing-TheIntegrator.52' 'System-Localization-TheIntegrator.106' 'System-Model-TheIntegrator.4' 'System-Platforms-TheIntegrator.81' 'System-Sources-TheIntegrator.50' 'System-Support-TheIntegrator.1215' 'Traits-TheIntegrator.907' 'Transcript-TheIntegrator.50' 'UIManager-TheIntegrator.187' 'Zinc-Character-Encoding-Core-TheIntegrator.48' 'Zinc-Resource-Meta-Core-TheIntegrator.58' 'NonInteractiveTranscript-TheIntegrator.25' 'AST-FFI-Pharo50Compatibility-TheIntegrator.2' 'System-SessionManager-TheIntegrator.27' 'PragmaCollector-TheIntegrator.12' 'Monticello-TheIntegrator.1132' 'Ring-Monticello-TheIntegrator.43').

    
    
    
packages do: [:packageName |
  (MCWorkingCopy forPackage: (MCPackage named: packageName)).
  (MCVersion package: (MCPackage named: packageName))].

RPackageOrganizer initializeDefaultFromMC.

localRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	
	
localRepository directory files sorted
	do: [ :each | | mcVersion |
	
      loader := MCVersionLoader new.	
      mcVersion := each basenameWithoutExtension.
      mcVersion logCr..
	loader addVersion: (localRepository versionFrom: mcVersion).
	loader load.		
].	
  
pharoRepository := MCHttpRepository
    location: 'http://smalltalkhub.com/mc/Pharo/Pharo50/main'
    user: ''
    password: ''.
      
versions do: [:versionName |
  | loader |
  versionName logCr.
  loader := MCVersionLoader new.	
  loader addVersion: (pharoRepository versionFrom: versionName).
  loader load.].
  
