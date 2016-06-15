	
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


| packages newPackages gofer |

MCMethodDefinition initializersEnabled: false.

[[ 
  ZnConnectionTimeout value: 300 during: [
    gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'SystemConfigurations'.
    gofer package: #ConfigurationOfMorphic.
    gofer load.
  ].

  ((Smalltalk at: #ConfigurationOfMorphic) project version: #stable) load.
	
] on:  ProvideAnswerNotification do: [:e | e resume: ''].
] on:  MCMergeOrLoadWarning do: [:w | w resume: true].	

MCMethodDefinition initializersEnabled: true.



UIManager default restoreDisplay. 

!


'From Pharo5.0 of 16 April 2015 [Latest update: #50756] on 12 May 2016 at 3:14:15.904849 pm'!

!Morph methodsFor: '*Keymapping-Core' stamp: 'GuillermoPolito 5/4/2013 16:02'!
attachKeymapCategory: aCategory
	! !

		
		

	Author fullName: 'MrCleaner'.
	"ImageCleaner new cleanUpMethods.
	
	FreeTypeFontProvider current initialize.
	EmbeddedFreeTypeFontInstaller initialize.
	SystemNavigation new
		allObjectsDo: [ :each | 
			(each respondsTo: #releaseCachedState)
				ifTrue: [ each releaseCachedState ] ].
	
	Smalltalk organization removeEmptyCategories.
	Smalltalk
		allClassesAndTraitsDo: [ :class |
			[ :each |
				each
					removeEmptyCategories;
					sortCategories ]
						value: class organization;
						value: class class organization ].
	Smalltalk organization sortCategories."
	Smalltalk garbageCollect.
	Smalltalk cleanOutUndeclared. 
	Smalltalk fixObsoleteReferences.
	"Smalltalk cleanUp: true except: #() confirming: false.	"
	
	BalloonEngine initialize.
	GradientFillStyle initialize.
	
	RubCharacterScanner initialize.
	RubSHTextStylerST80 initialize.
	RubCharacterScanner initialize.
	RubSHTextStylerST80 initialize.
	
	Smalltalk ui theme settings preferGradientFill: false.
	
	WorkingSession allInstancesDo: [:ws | ws instVarNamed: #deferredStartupActions put: OrderedCollection new].
	
	
	Author reset.
	
'fix finished' logCr.	





