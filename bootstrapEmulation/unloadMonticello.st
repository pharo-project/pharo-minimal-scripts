MCPackageManager allSubInstancesDo: [:o | o  unregister].
SystemAnnouncer uniqueInstance unsubscribe: MCWorkingCopy!

| mcPackage classes |

"Smalltalk at: #ListOfMethods put: (SystemNavigation default allMethods collect: #asString). "

WeakArray restartFinalizationProcess.

mcPackage := 'Monticello' asPackage.
mcPackage extensionMethods do: #removeFromSystem.

classes := mcPackage classes.
classes do: #removeFromSystem.

mcPackage := 'Ring-Monticello' asPackage.
mcPackage extensionMethods do: #removeFromSystem.

classes := mcPackage classes.
classes do: #removeFromSystem.

SystemAnnouncer reset.
ChangesLog reset default. "subscribe to SystemAnnouncer"

WeakArray restartFinalizationProcess.

!

Smalltalk snapshot: true andQuit: true.