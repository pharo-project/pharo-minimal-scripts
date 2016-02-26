'From Pharo5.0 of 16 April 2015 [Latest update: #50613] on 26 February 2016 at 2:34:57.325766 pm'!

!UIManager class methodsFor: 'initialization' stamp: 'PavelKrivanek 2/26/2016 14:32'!
forCurrentSystemConfiguration
	^ (self allSubclasses
			detect: [ :any | 
				any isValidForCurrentSystemConfiguration
					and: [ any subclasses noneSatisfy: #isValidForCurrentSystemConfiguration ] ]
			ifNone: [ NonInteractiveUIManager ]) new! !

!SmalltalkImage methodsFor: 'private' stamp: 'PavelKrivanek 5/21/2013 17:31'!
privSaveImageWithCleanup

	" Do not use this method for common image saving. This method is designated for saving the image during the shrinking process in headless images."
	
	20 timesRepeat: [
	  (Delay forMilliseconds: 50) wait.
	  Processor yield.
	  Smalltalk garbageCollect.
	].

	[
		self snapshot: true andQuit: true.
	] ifError: [:e |
		| rep |
		rep := FileStream forceNewFileNamed: 'PharoDebug.log'.
		rep nextPutAll: 'PharoKernel shrinking report'; cr.
		rep nextPutAll: 'Error:'; cr.
		rep nextPutAll: e asString; cr.
  		rep nextPutAll: thisContext stack size asString.
 	  	thisContext stack copy withIndexDo: [:stck :i |
			[ rep nextPutAll: i asString; space; nextPutAll: stck asString; cr] ifError: []].
		rep close. 
		Smalltalk exitFailure ]! !
			
| remove |

"save and restart image here"

SessionManager default unregisterClassNamed: #GTSpotterEventRecorderSettings.
SessionManager default unregisterClassNamed: #FFICallbackThunk.
SessionManager default unregisterClassNamed: #Alien.

(Smalltalk classNamed: #AlienWeakTable) allInstancesDo: [:table |
  WeakArray removeWeakDependent: table ].
WeakArray removeWeakDependent: (Smalltalk classNamed: #Callback).

remove := #('Athens-Cairo' 'NativeBoost-Tests'  'NativeBoost-Examples' 'NativeBoost-Unix' 'NativeBoost-Win32' 
'NativeBoost-Mac'   'NativeBoost-Core' 'NativeBoost-Pools' 'AsmJit-Tests' 'AsmJit-StackManagement' 
'AsmJit-Operands' 'AsmJit-x86'  'AsmJit-Extension' 'AsmJit-Instructions' 'AsmJit-Core' 'Alien' 'FFI-Kernel' 'FFI-MacOS'
'FFI-Pools' 'FFI-Tests' 'FFI-Unix' 'FFI-Win32').

remove do: [ :packageName |
    (MCWorkingCopy forPackage: (MCPackage named: packageName)) unload. ].

Smalltalk recreateSpecialObjectsArray.

Context initializePrimitiveSimulators.

SmalltalkImage current fixObsoleteReferences.
Behavior flushObsoleteSubclasses.
Smalltalk garbageCollect.

Smalltalk snapshot: true andQuit: true.


