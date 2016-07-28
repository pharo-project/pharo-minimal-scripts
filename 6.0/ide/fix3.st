
!MCClassDefinition methodsFor: 'installing' stamp: 'MarcusDenker 4/22/2015 19:23'!
createClass
	| superClass |
	
	name = #Context ifTrue: [^ self].
	
	superClass := superclassName == #nil ifFalse:
						[ Smalltalk globals at: superclassName ].
	^[PharoClassInstaller make: [ :builder | 
		builder
			superclass: superClass;
			name: name;
			layoutClass: (ObjectLayout layoutForType: type);
			slots: self instanceVariables;
			sharedVariables: self classVariables;
			sharedPools: self sharedPoolsString;
			classSlots: self classInstanceVariables;
			traitComposition: self traitCompositionCompiled;
			classTraitComposition: self classTraitCompositionCompiled;
			comment: comment stamp: commentStamp;
			category: category;
			environment:  superClass environment]] on: Warning, DuplicatedVariableError do: [:ex| ex resume].
	
! !

	
corruptedPackages := Set new.

packages := 'versions.txt' asFileReference readStream contentsOfEntireFile lines collect: [:pn | pn -> (pn copyUpToLast: $-) ].


"repo := MCHttpRepository
	location: 'http://smalltalkhub.com/mc/Pharo/Pharo60/main'
	user: ''
	password: ''.
"
repo := MCFileTreeRepository new directory: 'pharo-core' asFileReference.
	
packages do: [ :assoc |
	| needsFix |
	Transcript show: assoc key; show: ' -> '; flush.
	needsFix := ((MCWorkingCopy forPackage: (MCPackage named: assoc value)) changesRelativeToRepository: repo) isEmpty not.
	Transcript show: needsFix; cr.
	needsFix ifTrue: [ 
		corruptedPackages add: assoc.
		[ [ 
		Gofer it smalltalkhubUser:  'Pharo' project:  'Pharo60'; version: assoc key;  load.
	
] on:  ProvideAnswerNotification do: [:e | 
  Transcript show: 'ProvideAnswerNotification '; show: e asString; cr.
  e resume:  ''].
] on:  MCMergeOrLoadWarning do: [:w | 
  Transcript show: 'MCMergeOrLoadWarning '; show: w asString; cr.
  w resume: true].	
		 ]
		 ifFalse: [
	    (MCWorkingCopy forPackage: (MCPackage named: assoc value)) modified: false.
	 ].

	 ].
	 
	 
Transcript show: 'Corrupted packages:'; cr.
corruptedPackages do: [ :assoc | Transcript show: assoc; cr. ].
Transcript cr.	 