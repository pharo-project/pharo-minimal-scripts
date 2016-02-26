'From Pharo5.0 of 16 April 2015 [Latest update: #50613] on 26 February 2016 at 2:34:57.325766 pm'!

!UIManager class methodsFor: 'initialization' stamp: 'PavelKrivanek 2/26/2016 14:32'!
forCurrentSystemConfiguration
	^ (self allSubclasses
			detect: [ :any | 
				any isValidForCurrentSystemConfiguration
					and: [ any subclasses noneSatisfy: #isValidForCurrentSystemConfiguration ] ]
			ifNone: [ NonInteractiveUIManager ]) new! !
			
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


