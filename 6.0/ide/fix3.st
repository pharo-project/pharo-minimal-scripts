corruptedPackages := Set new.

packages := 'versions.txt' asFileReference readStream contentsOfEntireFile lines collect: [:pn | pn -> (pn copyUpToLast: $-) ].

repo := MCHttpRepository
	location: 'http://smalltalkhub.com/mc/Pharo/Pharo60/main'
	user: ''
	password: ''.
	
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
	    (MCWorkingCopy forPackage: (MCPackage named: assoc value) modified: false.
	 ].
	 
	 
Transcript show: 'Corrupted packages:'; cr.
corruptedPackages do: [ :assoc | Transcript show: assoc; cr. ].
Transcript cr.	 