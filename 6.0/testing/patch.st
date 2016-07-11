'From Pharo6.0 of 13 May 2016 [Latest update: #60143] on 11 July 2016 at 11:28:54.661847 am'!

!IRBytecodeGenerator methodsFor: 'results' stamp: 'PavelKrivanek 7/11/2016 11:28'!
addProperties: cm
	"set the properties of cm according to properties saved"
	properties ifNotNil: [
		cm penultimateLiteral: properties.
		properties  method: cm.
		properties  pragmas do: [:each | each setMethod: cm] ].! !

		
'From Pharo5.0 of 16 April 2015 [Latest update: #50697] on 19 April 2016 at 1:12:21.695763 pm'!

!ReleaseTest class methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/23/2013 20:47'!
knownProcesses
	"Return a dynamic list of know processes"
	
	"(self actualProcesses difference: self knownProcesses) do: [ :each | each suspend; terminate ]."
	
	^ {
		Processor activeProcess.	
		WeakArray runningFinalizationProcess.
		Processor backgroundProcess.
		SmalltalkImage current lowSpaceWatcherProcess.
		Delay schedulingProcess } asSet! !




'From Pharo5.0 of 16 April 2015 [Latest update: #50697] on 19 April 2016 at 11:58:31.961093 am'!

!PlatformResolver methodsFor: 'private' stamp: 'EstebanLorenzano 3/10/2015 15:27'!
directoryFromEnvVariableNamed: aString or: aBlock
	| envValue |
	envValue := [ Smalltalk os environment at: aString ifAbsent: [ nil ] ]
		on: Error
		do: [ ^ RelativePath new asFileReference  ].
	^ envValue isEmptyOrNil
		ifTrue: [ aBlock value ]
		ifFalse: [ self resolveString: envValue ]! !




'From Pharo5.0 of 16 April 2015 [Latest update: #50697] on 19 April 2016 at 11:47:30.627278 am'!

!CompiledMethod methodsFor: '*rpackage-core' stamp: 'NicolaiHess 2/3/2016 08:57'!
packageFromOrganizer: anRPackageOrganizer
	| originSelector |
	"This method returns the package this method belongs to.  
	It takes into account classes and traits.  
	If the method is in no package, returns nil by now"
	self flag: 'TODO: use anRPackageOrganizer, or better delegate to anRPackageOrganizer'.
	originSelector := self originMethod selector.
	^self origin packages 
		detect: [ :each | 
			(each includesSelector: originSelector ofClassName: self origin theNonMetaClass originalName) 
			or: [ each includesSelector: originSelector ofMetaclassName: self origin theNonMetaClass originalName]] 
		ifNone: [ '_UnpackagedPackage' asPackage ]! !


RPackageOrganizer default registerPackageNamed: '_UnpackagedPackage'.


((CompiledMethod allInstances select: [:m | m package isNil ]) collect: #methodClass as: Set) logCr.
!

'From Pharo5.0 of 16 April 2015 [Latest update: #50697] on 19 April 2016 at 11:20:14.180497 am'!

!RPackageIncrementalTest methodsFor: 'setup' stamp: 'StephaneDucasse 6/3/2012 22:46'!
tearDown
	
	| logging |
	createdPackages  do: [:each | self removePackage: each name].
	"just remove package from package organizer dictionary"
	
	createdPackages  do: [:each |
		
		each extendedClasses do: [ :extendedClass|
			self packageClass organizer
		 		unregisterExtendingPackage: each forClass: extendedClass.]].
	"all ***extending*** classes the packages are also unregistered from PackageOrganizer"									
	(createdClasses reject: [:c| c isObsolete]) do: [:cls| 
		"(RPackage organizer includesPackageBackPointerForClass: cls) 
			ifTrue: [cls package unregisterClass: cls.]. 
		when RPackageOrganizer was not looking at system event we had to do the commented actions"
		logging := false.
		cls removeFromSystem: logging.  
		"not logging so no event are raised"
		"but this also means that the consistency cannot be ensured by internal system announcer too."
		].					
	createdCategories do: [:each | 
		|mCPackage|
		SystemOrganization removeCategory: each.
		 ].
	super tearDown.! !





'From Pharo5.0 of 16 April 2015 [Latest update: #50697] on 19 April 2016 at 11:03:26.642592 am'!

!RBParserTest methodsFor: 'accessing' stamp: 'MarcusDenker 7/30/2015 08:04'!
exampleClasses
	^ Array with: RBParser with: RBScanner with: RBProgramNode! !

	
'From Pharo5.0 of 16 April 2015 [Latest update: #50697] on 19 April 2016 at 10:59:59.980164 am'!

!ArrayTest methodsFor: 'testing' stamp: 'CamilloBruni 8/31/2013 20:23'!
testComplexIsSelfEvaluating
	"self run: #testComplexIsSelfEvaluating"

	| complexArray restoredArray |
	complexArray := {1.
	true.
	false.
	nil.
	#a.
	'a'.
	$a.
	(Float pi).
	(Float halfPi).
	(4 / 5).
	(Float infinity negated).
	(1 @ 2).
	(0 @ 0 extent: 1 @ 1).
	('hola' -> 0).
	Object.
	(Object class)}.
	complexArray := complexArray copyWith: complexArray.
	self assert: complexArray isSelfEvaluating.
	restoredArray := self class evaluate: complexArray printString.
	self assert: restoredArray = complexArray! !

	
'From Pharo5.0 of 16 April 2015 [Latest update: #50697] on 19 April 2016 at 10:55:37.519091 am'!

!SelfEvaluatingObjectTest methodsFor: 'tests' stamp: 'StephaneDucasse 10/16/2011 18:16'!
testObjects
	"self debug: #testObjects"

	self assert: 10 isSelfEvaluating.
	self assert: $a isSelfEvaluating.
	self assert: 3.14157 isSelfEvaluating.
	self assert: #(1 2 3) isSelfEvaluating.
	self assert: #abc isSelfEvaluating.
	self assert: 'abc' isSelfEvaluating.

	self assert: Object isSelfEvaluating.
	self assert: Object new isSelfEvaluating not.
	
	self assert: {Float infinity . Float nan. Float infinity negated} isSelfEvaluating.

	self assert: (Array with: 10) isSelfEvaluating.
	self assert: (Array with: Object new) isSelfEvaluating not.

	self assert: true isSelfEvaluating.
	self assert: false isSelfEvaluating.

	self assert: nil isSelfEvaluating.

	self assert: (1 to: 10) isSelfEvaluating.
	self assert: (1->2) isSelfEvaluating.! !



'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:58:50.276726 pm'!

!Integer methodsFor: 'bit manipulation' stamp: 'eem 1/16/2008 13:57'!
| anInteger
	^self bitOr: anInteger! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:53:57.803757 pm'!

!SplitJoinTest methodsFor: 'running' stamp: 'PavelKrivanek 3/22/2016 16:53'!
testSplitJoinBoundaryCases
	"Empty splitter, joiner or sequence."
	self assert: (#() join: (#() split: #())) equals: #().
	self assert: ('' join: ('' split: '')) equals: ''.
	self assert: ('' join: (#(''))) equals: ''. "NB: Doesn't work with empty regex"

	"Overlapping splitters, or at end of sequence"
	self assert: ('an' join: ('an' split: 'banana')) equals: 'banana'.
	self assert: ('na' join: ('na' split: 'banana')) equals: 'banana'.
	self assert: ('ana' join: ('ana' split: 'banana')) equals: 'banana'.
! !


'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:38:11.271827 pm'!

!RPackage methodsFor: 'accessing' stamp: 'PavelKrivanek 3/22/2016 16:38'!
renameTo: aSymbol
	"Rename a package with a different name, provided as a symbol"
	| oldName newName oldCategoryNames  |

	oldName := self name.
	newName := aSymbol asSymbol.
	
	(self organizer includesPackageNamed: aSymbol)
		ifTrue: [ RPackageConflictError  signal: ('A package named {1} already exists' format: { aSymbol }) ].

	oldCategoryNames  := (self classTags collect: #categoryName as: Set) 
		add: self categoryName;
		yourself.
	self name: aSymbol.
	SystemAnnouncer uniqueInstance suspendAllWhile: [
		self definedClasses do: [ :each | each category: newName, (each category allButFirst: oldName size) ].
		oldCategoryNames do: [ :each | SystemOrganizer default removeCategory: each ] ].
	self renameTagsPrefixedWith: oldName to: newName. 
	self renameExtensionsPrefixedWith: oldName to: newName.
			
	self organizer 
		basicUnregisterPackageNamed: oldName;
		basicRegisterPackage: self.

	SystemAnnouncer uniqueInstance 
		announce: (RPackageRenamed 
			to: self 
			oldName: oldName 
			newName: newName).! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:32:51.570954 pm'!

!RPackageRenameTest methodsFor: 'tests' stamp: 'PavelKrivanek 3/22/2016 16:30'!
testRenamePackage
	"Test that we do rename the package as expected."
	| package  class |

	package := RPackageOrganizer default registerPackageNamed: 'Test1'.
	class := Object
		subclass: #TestClass
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'Test1-TAG'.
	self assert: (package includesClass: class).
	self assert: (package classTagNamed: #TAG ifAbsent: [ nil ]) notNil.
	self assert: ((package classTagNamed: #TAG ifAbsent: [ nil ]) includesClass: class).
	package renameTo: 'TestRename'.
	self assert: (package includesClass: class).
	self assert: (package classTagNamed: #TAG ifAbsent: [ nil ]) notNil.
	self assert: ((package classTagNamed: #TAG ifAbsent: [ nil ]) includesClass: class).
	self assert: class category = #'TestRename-TAG'.	
	self deny: (Smalltalk organization includesCategory: #Test1).
	
	"cleaning"
	self deny: (RPackageOrganizer default includesPackageNamed: #TestRename).
! !



'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:21:12.227087 pm'!

!RPackageOrganizer methodsFor: 'private registration' stamp: 'MarcusDenker 7/16/2014 17:25'!
basicUnregisterPackage: aPackage
	"Unregister the specified package from the list of registered packages. Raise the announcement RPackageUnregistered. This is a low level action. It does not unregister the back pointer from classes to packages or any other information managed by the organizer"
	
	packages
		removeKey: aPackage name asSymbol
		ifAbsent: [ self reportExtraRemovalOf: aPackage ].
	"unregister also mc package"
	"aPackage mcPackage 
		ifNotNil: [ :mcPackage | mcPackage workingCopy unregister ]."! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:13:45.663469 pm'!

!MockSourceEditor methodsFor: 'as yet unclassified' stamp: 'PavelKrivanek 3/22/2016 15:34'!
insertAndSelect: aString at: anInteger

	text := (text first: anInteger-1), 
		(' ' , aString) asString, 
		(text copyFrom: anInteger to: text size).
		
	selectionStart := anInteger.
	selectionEnd := anInteger + aString size ! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 1:28:43.72991 pm'!

!ArrayTest methodsFor: 'initialization' stamp: 'PavelKrivanek 3/22/2016 13:28'!
setUp

	
	literalArray := #(1 true 3 #four).
	selfEvaluatingArray := { 1. true. (3/4). String loremIpsum. (2 to: 4) . 5 }.
	nonSEArray1 := { 1 . Set with: 1 }.
	nonSEarray2 := { Smalltalk globals associationAt: #Array }.
	example1 := #(1 2 3 4 5) copy.
	indexArray:= {2. 3. 4.}.
	valueArray:={0. 0. 0.}.
	oldSubCollection:= {2. 3. 4.}.
	nonEmptyMoreThan1Element:= example1.
	subCollectionNotIn:= {1. 8. 3.}.
	collectionNotIncluded:= {7. 8. 9.}.
	removedCollection:=  { 2. 4. }.
	
	example2 := {1. 2. 3/4. 4. 5}.
	collectionWith4Elements := #(1 -2 3 1). 
	collectionWithoutNil := #( 1 2 3 4).
	simpleCollection := #( 1 8 3).
	collectionOfCollectionsOfInts := { 1. { 2. 3 }. { 4. { 5. 6} } }.
	collectionOfCollectionsOfStrings:= {{{'foo'}. {'bar'}}. 'zorg'}.
	collectResult := {SmallInteger. SmallInteger. SmallInteger. SmallInteger.}.
	empty := #().
	duplicateElement := 5.2.
	withEqualElements := {1.5. duplicateElement . 6.1. 2.0. duplicateElement .} .
	withoutEqualElements := {1.1. 4.4. 6.5. 2.4. 3.1.}.
	withCharacters := {$a. $x. $d. $c. $m.}.
	unsortedCollection := {1. 2.  8. 5. 6. 7.}.
	sortedInAscendingOrderCollection := {1. 2. 3. 4. 5. 6.}.
	elementInForCopy:= 2.
	elementNotInForCopy:= 9.
	firstIndex:= 2.
	secondIndex:= 4.
	replacementCollection:= {4. 3. 2. 1.}.
	replacementCollectionSameSize := {5. 4. 3.}.	
	nonEmpty1Element:={ 5.}.
	collectionOfCollection:={1.5. 5.5. 6.5.}.
	collectionOfFloatWithEqualElements:={1.5. 5.5. 6.5. 1.5}.
	floatCollectionWithSameBeginingAnEnd := {1.5. 5.5. 1.5 copy}.
	collection5Elements := { 1. 2. 5. 3. 4.}.! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 1:50:05.945381 pm'!

!OCNewCompilerWithChangesFunctionalTests methodsFor: 'other-tests' stamp: 'PavelKrivanek 3/22/2016 13:49'!
testModulePrimitive
	
	| aCompiledMethod bytecode index |
	aCompiledMethod := OpalCompiler new 
	source: 'copyBitsAgain
	"Primitive. See BitBlt|copyBits, also a Primitive. Essential. See Object
	documentation whatIsAPrimitive."

	<primitive: ''primitiveCopyBits'' module: ''BitBltPlugin''>
	self primitiveFailed';
	class: MockForCompilation;
	compile.
									
	bytecode := aCompiledMethod symbolic asString substrings: String cr.
	index := 0.
	self assert: (bytecode at: (index := index + 1)) = '<primitive: ''primitiveCopyBits'' module: ''BitBltPlugin''>'.
	self assert: (bytecode at: (index := index + 1)) = '21 <8B 75 00> callPrimitive: 117'.
	self assert: (bytecode at: (index := index + 1)) = '24 <70> self'.
	self assert: (bytecode at: (index := index + 1)) = '25 <D1> send: primitiveFailed'.
	self assert: (bytecode at: (index := index + 1)) = '26 <87> pop'.
	self assert: (bytecode at: (index := index + 1)) = '27 <78> returnSelf'.	

	! !

!DictionaryTest methodsFor: 'requirements' stamp: 'monty 10/12/2015 23:58'!
otherDictionaryClasses
	"(DictionaryTest withAllSubclasses collect: [:each | each new classToBeTested]) asArray"
	^ {SmallDictionary. IdentityDictionary. PluggableDictionary.
		WeakValueDictionary. SystemDictionary. WeakKeyDictionary. SmallIdentityDictionary.
		WeakIdentityKeyDictionary. WeakKeyToCollectionDictionary. Dictionary}
			reject: [:each | each new species == self classToBeTested new species]! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:26:22.964083 pm'!

!RPackageRenameTest methodsFor: 'tests' stamp: 'PavelKrivanek 3/22/2016 16:26'!
testUnregisterPackage
	"Test that we do rename the package as expected."
	| package class |

	package := RPackageOrganizer default registerPackageNamed: 'Test1'.
	class := Object
		subclass: #TestClass
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'Test1-TAG'.
	self assert: (package includesClass: class).
	self assert: (package classTagNamed: #TAG ifAbsent: [ nil ]) notNil.
	self assert: ((package classTagNamed: #TAG ifAbsent: [ nil ]) includesClass: class).
	
	package unregister.
	
	self deny: (RPackageOrganizer default includesPackageNamed: #Test1).
	! !

