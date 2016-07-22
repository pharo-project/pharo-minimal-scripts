#(#ISOLanguageDefinition #Delay #ZipFileConstants #DangerousClassNotifier #ISO885915TextConverter #EndianDetector
#DigitalSignatureAlgorithm #ChangeSet #Float #OSPlatform #Behavior #OCASTTranslator #ExternalSemaphoreTable 
#ProcessSpecificVariable #LiteralVariable #ByteTextConverter #ZipWriteStream #FileHandle #GZipConstants 
#WeakFinalizationList #RPackageOrganizer #Slot #DateAndTime #HashTableSizes #DiskStore #SHA1 #CP1252TextConverter
#ProcessorScheduler #Categorizer #CCompilationContext #SetElement #Deprecation #ZnMimeType #TraitBehavior 
#AsyncFile #RPackage #InflateStream #Stdio #FileStream #ASTCache #MacRomanTextConverter 
#CompiledMethod  #ISO88592TextConverter #UUIDGenerator #FastInflateStream #Locale #Symbol
#BISimpleFormatter #ZipConstants #InstructionStream #TemporaryVariable #MD5NonPrimitive #ChronologyConstants 
#BasicCommandLineHandler #CompilationContext #FileLocator #LanguageEnvironment #Character #SmalltalkImage 
#EncodedCharSet #ByteString #SmallInteger #String  #WeakArray #Object #Latin9Environment
 #Latin2Environment #Key #ZnBase64Encoder #UIManagerSessionHandler #MultiByteFileStream 
#Latin1  #RBScanner #CP1250TextConverter #WeakAnnouncementSubscription #ZnUTF8Encoder #Context #Unicode 
#ZnSimplifiedByteEncoder)
  do: [:cn |
    Transcript show: 'initializing class: ', cn; cr.  
    (Smalltalk at: cn) initialize].!
    
!WorkingSession methodsFor: 'initialization' stamp: 'ChristopheDemarey 12/4/2015 11:43'!
initialize
	super initialize.
	deferredStartupActions := OrderedCollection new.
	creationTime := DateAndTime now.
	id := DateAndTime now hash.! !    

		
SessionManager classPool at: #Default put: SessionManager new.
		
SessionManager default installNewSession.


SessionManager default
		registerSystemClassNamed: #SmallInteger atPriority: 10; "system - 10"
		registerSystemClassNamed: #Delay atPriority: 20; "System - 20"
		registerSystemClassNamed: #ProcessorScheduler atPriority: 30; "System - 30"
		registerSystemClassNamed: #OSPlatform atPriority: 50; "System - 50"

		registerSystemClassNamed: #FileLocator atPriority: 90; "System - 90"
		
		registerSystemClassNamed: #Stdio; "System"
		registerSystemClassNamed: #LanguageEnvironment	; "System"
		registerSystemClassNamed: #DiskStore; "System"
		registerSystemClassNamed: #SmalltalkImage; "System"
		registerSystemClassNamed: #WeakFinalizationList; "System"
		registerSystemClassNamed: #Symbol; "System"
		registerSystemClassNamed: #Locale; "System"
		registerSystemClassNamed: #MultiByteFileStream; "System"
		registerSystemClassNamed: #WeakArray; "System"
		registerSystemClassNamed: #FileStream; "System"
		registerSystemClassNamed: #BasicCommandLineHandler; "System"
		registerSystemClassNamed: #NonInteractiveTranscript; "System"
		registerSystemClassNamed: #ASTCache; "System"
		registerSystemClassNamed: #EndianDetector. "System"
    
    
    !
    
    
'From Pharo6.0 of 13 May 2016 [Latest update: #60069] on 13 July 2016 at 2:53:22.90776 pm'!

!UnhandledError methodsFor: 'priv handling' stamp: 'ChristopheDemarey 8/14/2015 16:06'!
defaultAction

| rep |
	rep := FileStream forceNewFileNamed: 'PharoDebug.log'.
	rep nextPutAll: 'Error:'; cr.
	rep nextPutAll: exception asString; cr.
	rep nextPutAll: thisContext stack size asString.
	thisContext stack copy withIndexDo: [:stck :i |
		[rep nextPutAll: i asString; space; nextPutAll: stck asString; cr] ifError: []].
	rep close. 
	Smalltalk exitFailure
! !    


"Smalltalk saveAs: 'bootstrap_after_reloading'."

