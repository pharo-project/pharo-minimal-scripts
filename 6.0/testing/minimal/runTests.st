!UnhandledError methodsFor: 'priv handling' stamp: 'ChristopheDemarey 8/14/2015 16:06'!
defaultAction

| rep |
	rep := FileStream forceNewFileNamed: 'PharoDebug2.log'.
	rep nextPutAll: 'Error:'; cr.
	rep nextPutAll: exception asString; cr.
	rep nextPutAll: thisContext stack size asString.
	thisContext stack copy withIndexDo: [:stck :i |
		[rep nextPutAll: i asString; space; nextPutAll: stck asString; cr] ifError: []].
	rep close. 
	Smalltalk exitFailure
! !    

'From Pharo 6.0 of 13 May 2016 [Latest update: #60182] on 16 August 2016 at 3:15:10.542222 pm'!

!HDTestReport methodsFor: 'private' stamp: 'CamilloBruni 11/4/2013 08:27'!
stackTraceString: err of: aTestCase
	^ 'error' ! !


'From Pharo6.0 of 13 May 2016 [Latest update: #60069] on 13 July 2016 at 9:43:54.170076 am'!

!HDTestReport methodsFor: 'running' stamp: 'AndreiChis 10/7/2013 11:59'!
serializeError: error of: aTestCase


! !



(RPackage organizer packages collect: #name) logCr.

"HDTestReport runPackages: (RPackage organizer packages collect: #name)."

HDTestReport runClasses: Smalltalk allClasses named: 'Tests'.

Smalltalk exitSuccess. 