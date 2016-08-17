'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 9:16:23.516041 am'!

!MockSourceEditor methodsFor: 'as yet unclassified' stamp: 'PavelKrivanek 11/8/2012 13:31'!
insertAndSelect: aString at: anInteger

	text := (text first: anInteger-1), 
		(' ' , aString), 
		(text copyFrom: anInteger to: text size).
		
	selectionStart := anInteger.
	selectionEnd := anInteger + aString size ! !

	
!RPackageOrganizer methodsFor: 'private registration' stamp: 'MarcusDenker 7/16/2014 17:25'!
basicUnregisterPackage: aPackage
	"Unregister the specified package from the list of registered packages. Raise the announcement RPackageUnregistered. This is a low level action. It does not unregister the back pointer from classes to packages or any other information managed by the organizer"
	
	packages
		removeKey: aPackage name asSymbol
		ifAbsent: [ self reportExtraRemovalOf: aPackage ].
	"unregister also mc package"
	"aPackage mcPackage 
		ifNotNil: [ :mcPackage | mcPackage workingCopy unregister ]."! !
		
		
'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 9:44:59.384819 am'!

'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 9:45:58.02817 am'!

!ClassTestCase methodsFor: 'tests' stamp: 'CamilloBruni 5/1/2013 18:27'!
testClassComment
	! !

'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 10:23:21.574718 am'!

!SystemDictionaryTest methodsFor: 'problems' stamp: 'marcus.denker 7/29/2009 15:27'!
testClassComment
	! !


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
		
'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 10:51:07.123524 am'!

!RBMethodNode methodsFor: 'converting' stamp: 'MarcusDenker 7/7/2015 10:22'!
asSequenceNode
	^body! !
		