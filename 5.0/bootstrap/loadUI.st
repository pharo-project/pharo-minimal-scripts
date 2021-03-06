Smalltalk globals at: #Sensor put: InputEventSensor new.!
Sensor startUp!

'From Pharo5.0 of 16 April 2015 [Latest update: #50392] on 2 March 2016 at 5:59:15.374632 pm'!


		

'From Pharo5.0 of 16 April 2015 [Latest update: #50392] on 2 March 2016 at 5:23:15.125851 pm'!

!SmalltalkImage methodsFor: 'housekeeping'!
cleanOutUndeclared ! !

	
'From Pharo3.0 of 18 March 2013 [Latest update: #30438] on 1 October 2013 at 5:18:05 pm'!


!Unicode class methodsFor: 'Multilingual-OtherLanguages' stamp: 'yo 1/12/2004 18:00'!
isTraditionalChinese: code

  ^ false.
! !

!Unicode class methodsFor: 'Multilingual-OtherLanguages' stamp: 'PavelKrivanek 10/1/2013 17:17'!
isKorean: code

  ^ false
! !

!Unicode class methodsFor: 'Multilingual-OtherLanguages' stamp: 'PavelKrivanek 10/1/2013 17:17'!
isSimplifiedChinese: code

  ^ false

! !

!Unicode class methodsFor: 'Multilingual-OtherLanguages' stamp: 'PavelKrivanek 10/1/2013 17:18'!
isJapanese: code

  ^ false! !

!Unicode class methodsFor: 'Multilingual-OtherLanguages' stamp: 'PavelKrivanek 10/1/2013 17:17'!
isUnifiedKanji: code

  ^ false! !


'From Pharo3.0 of 18 March 2013 [Latest update: #30711] on 21 January 2014 at 9:18:56.165666 am'!

!Character methodsFor: 'accessing' stamp: 'CamilloBruni 8/31/2011 12:22'!
characterSet
  ^ (EncodedCharSet charsetAt: self leadingChar) ifNil: [Unicode]! !



[

| packages newPackages gofer |

MCMethodDefinition initializersEnabled: false.


[[ 
  ZnConnectionTimeout value: 300 during: [
    gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'SystemConfigurations'.
    gofer package: #ConfigurationOfUI.
    gofer load.
  ].

  ((Smalltalk at: #ConfigurationOfUI) project version: '5.392') load.
] on:  ProvideAnswerNotification do: [:e | e resume: ''].
] on:  MCMergeOrLoadWarning do: [:w | w resume: true].

MCMethodDefinition initializersEnabled: true.

SmalltalkImage current snapshot: true andQuit: false.
SmalltalkImage current snapshot: true andQuit: true.

UIManager default restoreDisplay. 

] ifError: [:e |
	| rep |
	rep := FileStream forceNewFileNamed: 'PharoDebug.log'.
	rep nextPutAll: 'Error:'; cr.
	rep nextPutAll: e asString; cr.
	rep nextPutAll: thisContext stack size asString; cr.
	thisContext stack copy withIndexDo: [:stck :i |
		[rep nextPutAll: i asString; space; nextPutAll: stck asString; cr] ifError: [:er | rep nextPutAll: er asString; cr]].
	rep close. 
	Smalltalk exitFailure.]



