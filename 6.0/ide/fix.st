 
[
[

'versions.txt' asFileReference readStream contentsOfEntireFile lines do: [ :versionName |
	Transcript show: 'Loading '; show: versionName; cr.
	Gofer it smalltalkhubUser:  'Pharo' project:  'Pharo60'; version: versionName;  load. ].

] on:  ProvideAnswerNotification do: [:e | 
  Transcript show: 'ProvideAnswerNotification '; show: e asString; cr.
  e resume:  ''].
] on:  MCMergeOrLoadWarning do: [:w | 
  Transcript show: 'MCMergeOrLoadWarning '; show: w asString; cr.
  w resume: true].	

 
!
 
 Smalltalk tools register: GTGenericStackDebugger as: #debugger.

Smalltalk tools registeredDebuggersWithRanks.
Smalltalk tools debuggers add: (GTGenericStackDebugger->3).
Smalltalk tools debuggers add: (GTSUnitDebugger->70).
Smalltalk tools debuggers add: (GTBytecodeDebugger->5).

Smalltalk tools register: GTPlayground as: #workspace.
Smalltalk tools register: GTInspector as: #inspector.
Smalltalk tools register: ExternalChangesBrowser as: #changeList.
Smalltalk tools register: FileList as: #fileList.
Smalltalk tools register: Finder as: #finder.
Smalltalk tools register: ProcessBrowser as: #processBrowser.
Smalltalk tools register: RecentMessageList as: #recentMessageList.
Smalltalk tools register: SyntaxErrorDebugger as: #syntaxErrorDebugger.
Smalltalk tools register: TimeProfiler as: #timeProfiler.

(MorphicCoreUIManager classPool at: #UIProcess) terminate.
MorphicCoreUIManager classPool at: #UIProcess put: nil.

PolymorphSystemSettings desktopColor:  Color veryVeryLightGray lighter.
SourceCodeFonts setSourceCodeFonts: 10.
FreeTypeSystemSettings loadFt2Library: true.
FreeTypeSettings current monitorType: #LCD.
FreeTypeSettings current glyphContrast: 55.

RealEstateAgent usedStrategy: #cascadeFor:initialExtent:world:.
GrowlMorph position: #bottomLeft.
ShortcutReminder enabled: true.

OSTouchOneFingerDoubleTapDetector maxDistance: 0.05.
OSTouchOneFingerDoubleTapDetector doubleTouchSpeed: 700.
OSTouchPinchDetector maxDistanceBetweenFingersLine: 0.2.
OSTouchPinchDetector minDistanceBeforeDetection: 0.05.
OSTouchRotationDetector minAngleBeforeDetection: 10.
OSTouchScrollDetector minDistanceBeforeDetection: 0.05.
OSTouchScrollDetector persistentDirection: false.
OSTouchSwipeDetector minDistToBorder: 0.1.
OSTouchSwipeDetector minDistanceBeforeDetection: 0.05.

QASettings nautilusPlugin: true.

KMRepository reset.
Morph shortcutsHandler: KMShortcutHandler new.

"because of Komitter"
MCSaveVersionDialog previousMessages add: String new.

RBProgramNode formatterClass: BIConfigurableFormatter.