| remove |

"save and restart image here"

Smalltalk removeFromStartUpList: (Smalltalk classNamed: #GTSpotterEventRecorderSettings).
Smalltalk removeFromStartUpList: (Smalltalk classNamed: #FFICallbackThunk).
Smalltalk removeFromStartUpList: (Smalltalk classNamed: #Alien).
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

(Smalltalk classNamed: #AJx86GPRegister) removeFromSystem. 
(Smalltalk classNamed: #NativeBoostMac32) removeFromSystem.
(Smalltalk classNamed: #AJMMRegister) removeFromSystem.
(Smalltalk classNamed: #AJx87Register) removeFromSystem.
(Smalltalk classNamed: #AJxMMRegister) removeFromSystem.
(Smalltalk classNamed: #AJx64RipRegister) removeFromSystem.
Context initializePrimitiveSimulators.

SmalltalkImage current fixObsoleteReferences.
Behavior flushObsoleteSubclasses.
Smalltalk garbageCollect.

Smalltalk snapshot: true andQuit: true.


