

	Author fullName: 'MrCleaner'.
	ImageCleaner new cleanUpMethods.
	
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
	Smalltalk organization sortCategories.
	Smalltalk garbageCollect.
	Smalltalk cleanOutUndeclared. 
	Smalltalk fixObsoleteReferences.
	"Smalltalk cleanUp: true except: #() confirming: false."
	
  Smalltalk addToStartUpList: Cursor.
  Smalltalk addToShutDownList: Form.

  InputEventSensor startUp.
  InputEventSensor installEventSensorFramework.
	
	
	Author reset.


Smalltalk snapshot: true andQuit: true.

