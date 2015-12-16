FileStream stdout nextPutAll: 'Shrinking...'; lf.!


[
  | kernelPackages networkPackages goferPackages metacelloPackages tests keep o 
    ordered notResolved foundDeps deps depsList resolveBlock hasResolved 
    delete cyclic notResolvedNames sortedByDeps |

  [ 
    World submorphs do: #delete.
    UIManager default terminateUIProcess.

    " clean processes"
    (Process allInstances
      reject: [ :process | 
        {(InputEventFetcher default instVarNamed: #fetcherProcess).
        (Processor activeProcess).
        (WeakArray runningFinalizationProcess).
        (Processor backgroundProcess)} includes: process ])
      do: [ :process | 
        process suspend.
        process terminate ].
    Delay restartTimerEventLoop.
    

    kernelPackages := #('AST-Core' 'Alien' 'Announcements-Core' 'Announcements-Core' 'Collections-Abstract' 
      'Collections-Arithmetic' 'Collections-Atomic' 'Collections-Native' 
      'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams' 'Collections-Strings' 
      'Collections-Support' 'Collections-Unordered' 
      'Collections-Weak' 'Compression' 'Files' 'Graphics-Display Objects' 
      'Graphics-Primitives' 'Graphics-Transformations' 'Kernel' 'Random-Core' 'Multilingual-Encodings' 
      'Multilingual-Languages' 'Multilingual-TextConversion' 'System-Changes' 'System-BasicCommandLineHandler' 'System-CommandLine' 'System-CommandLineHandler' 
      'System-Clipboard' 'System-FileRegistry' 'System-Finalization' 'System-Localization' 
      'System-Object Events' 'System-Platforms' 'System-Support' 'System-Model' 'System-Sources' 'Text-Core' 'Traits' 'UIManager' 
      'Transcript' 'FileSystem-Core' 'FileSystem-Disk' 'FileSystem-Memory' 
      'CodeImport' 'CodeImportCommandLineHandlers' 'Regex-Core' 'System-Announcements' 'Ring-Core-Kernel' 'CodeExport'
      'Ring-Core-Containers' 'OpalCompiler-Core' 
      'Slot' 'NonInteractiveTranscript' 'System-Hashing' 'UserManager-Core' 'StartupPreferences' 'ConfigurationCommandLineHandler-Core' 'PragmaCollector' 'Jobs' 'System-VMEvents' 'Reflectivity').

    networkPackages := #('Zinc-Resource-Meta-Core' 'Zinc-Character-Encoding-Core' 'Network-Kernel' 
      'Network-MIME' 'Network-UUID' 'Network-Url'  'Network-Protocols' 'Zinc-HTTP' 'Zinc-FileSystem' 'Zodiac-Core').

    goferPackages := #('System-FileRegistry' 'RPackage-Core' 'RPackage-SystemIntegration' 
      'Monticello' 'MonticelloConfigurations' 'Ring-Monticello' 'Gofer-Core' 
      'MonticelloFileTree-Core' 'MonticelloFileTree-FileSystem-Utilities' 'System-FilePackage'
      'MonticelloRemoteRepositories' 'MonticelloMocks' 'RingChunkImporter').

    tests := #('AST-Interpreter-Test' 'AST-Tests-Core' 'Announcements-Tests-Core' 'AsmJit-Tests' 
      'ClassOrganizer-Tests' 'ConfigurationCommandLineHandler-Tests' 'FileSystem-Tests-Core' 
      'FileSystem-Tests-Disk' 'FileSystem-Tests-Memory' 'Gofer-Tests' 'Graphics-Tests' 
      'HelpSystem-Tests' 'Keymapping-Tests' 'Manifest-Resources-Tests' 'Manifest-Tests' 
      'Metacello-TestsCore' 'Metacello-TestsMC' 'Metacello-TestsMCCore' 'Metacello-TestsMCResources' 
      'Metacello-TestsPharo20MC' 'Metacello-TestsPlatform' 'Metacello-TestsTutorial' 
      'Multilingual-Tests' 'NativeBoost-Tests' 'OpalCompiler-Tests' 'ProfStef-Tests' 'RPackage-Tests' 
      'Refactoring-Tests-Changes' 'Refactoring-Tests-Core' 'Refactoring-Tests-Critics' 
      'Refactoring-Tests-Environment' 'Regex-Tests-Core' 'Ring-Tests-Containers' 'Ring-Tests-Kernel' 
      'Ring-Tests-Monticello' 'SUnit-Tests' 'SUnit-UITesting' 'Spec-Tests' 'Text-Tests' 
      'UpdateStreamer-Tests' 'Zinc-Character-Encoding-Tests' 'Zinc-Resource-Meta-Tests' 'Zinc-Tests' 
      'Zodiac-Tests' 'FuelTests' 'KernelTests' 'MorphicTests' 'NetworkTests' 'ShoutTests' 'SlotTests' 
      'Tests' 'BalloonTests' 'CollectionsTests' 'CompressionTests' #'Debugger-Tests' 'EmbeddedFreeType-Tests' 'FontInfrastructure-Tests' 'FreeTypeTests' 'Graphics-Fonts-Tests' 'Monticello-Tests' 'NECompletion-Tests' 'Nautilus-Tests' 'Reflectivity-Tests' 'ReleaseTests' #'ScriptLoader-Tests' 'Slot-Tests' 'SmartSuggestions-Tests' 'System-CachingTests' 'System-History-Tests' 'System-Localization-Tests' 'Text-Edition-Tests' 'Tool-FileList-Tests' 'ToolsTest' 'UserManager-Tests' 'Versionner-Tests-Core-Commands' 'Versionner-Tests-Core-DependenciesModel' 'Versionner-Tests-Resources').

    metacelloPackages := #('Metacello-Core' 'Metacello-Base' 'Metacello-MC' 
      'Metacello-PharoCommonPlatform'  'Metacello-Platform' 'Metacello-Platform.pharo30' 'Metacello-ToolBox').
      
    packagesWithConfiguration := #('Athens-Balloon' 'Athens-Cairo' 'Athens-CairoPools' 'Athens-Core' 'Athens-Examples' 'Athens-Morphic' 'Athens-Text' 'ConfigurationOfAthens' 'ConfigurationOfGlamourCore' 'ConfigurationOfGTInspectorCore' 'ConfigurationOfGToolkitCore' 'ConfigurationOfGTPlaygroundCore' 'ConfigurationOfGTSpotter' 'ConfigurationOfOSWindow' 'ConfigurationOfRubric' 'ConfigurationOfShoreLineReporter' 'ConfigurationOfTxText' 'ConfigurationOfVersionner' 'ConfigurationOfZincHTTPComponents' 'Glamour-Announcements' 'Glamour-Browsers' 'Glamour-Core' 'Glamour-Examples' 'Glamour-Helpers' 'Glamour-Morphic-Brick' 'Glamour-Morphic-Brick-Tests' 'Glamour-Morphic-Pager' 'Glamour-Morphic-Renderer' 'Glamour-Morphic-Theme' 'Glamour-Morphic-Widgets' 'Glamour-Presentations' 'Glamour-Rubric-Presentations' 'Glamour-Tests-Core' 'Glamour-Tests-Morphic' 'Glamour-Tests-Resources' 'Glamour-Tests-Rubric' 'GT-Inspector' 'GT-InspectorExtensions-Core' 'GT-Playground' 'GT-Spotter' 'GT-Spotter-EventRecorder' 'GT-SpotterExtensions-Core' 'GT-Tests-Inspector' 'GT-Tests-Playground' 'GT-Tests-Spotter' 'OSWindow-SDL2' 'OSWindow-VM' 'Rubric' 'ShoreLine-Report-Core' 'ShoreLine-Report-Settings' 'ShoreLine-Report-UI' 'TxText-AthensTests' 'TxText-Model' 'TxText-Styler' 'TxTextTests-Model' 'Versionner-Core-Commands' 'Versionner-Core-Model' 'Versionner-Spec-Browser' 'Versionner-Tests-Core-Model' 'Zinc-HTTP' 'Zinc-Character-Encoding-Core' 'Zinc-Character-Encoding-Tests' 'Zinc-Resource-Meta-Core' 'Zinc-Resource-Meta-Tests' 'Zinc-Tests' 'Zinc-Zodiac' 'Zodiac-Core' 'Zodiac-Tests').      

    keep := kernelPackages, networkPackages, goferPackages, metacelloPackages.

    " clean "
    KMRepository reset.
    KMPragmaKeymapBuilder release.
    RecentMessageList stopNotifications.
    NOCCompletionTable reset.
    SystemAnnouncer uniqueInstance unsubscribe: NOCCompletionTable.
    MCWorkingCopyBrowser allInstances do: [ 
        :mcwcb | SystemAnnouncer uniqueInstance unsubscribe: mcwcb].
    ZnNetworkingUtils default secureSocketStreamClass: nil.
    ZnNetworkingUtils default socketStreamClass: SocketStream.
    TextConstants TextSharedInformation removeKey: #DefaultTextStyle.
    TextConstants TextSharedInformation removeKey: #DefaultMultiStyle.
    TextConstants TextSharedInformation removeKey: #DefaultFixedTextStyle.
    TextConstants TextSharedInformation removeKey: (Smalltalk classNamed: #StrikeFont) defaultFontKey.
    Smalltalk allClasses select: [ :c | c sharedPools includes: TextConstants ] thenDo: [ :c | c compileAll ].

    " change UI manager"
    UIManager default: DummyUIManager new.

    FileStream stdout nextPutAll: 'Removing tests...'; lf.

    tests
      withIndexDo: [ :packageName :index | 
        | wc |
        wc := MCWorkingCopy forPackage: (MCPackage named: packageName).
        FileStream stdout nextPutAll: index asString , '/' , tests size asString , ' - unloading ' , wc packageName; lf.
        wc unload ].

    " count unloading order and select packages with cyclic dependencies "
    cyclic := OrderedCollection new.
    [ 
      deps := Dictionary new.
      (MCWorkingCopy allManagers collect: #packageName)
        do: [ :packageName | 
          | package |
          package := RPackageSet named: packageName.
          deps at: packageName put: (package extensionMethods 
            groupedBy: [ :m | (Smalltalk classOrTraitNamed: m className) package packageName ]) keys ].
      depsList := deps associations asOrderedCollection.
      resolveBlock := [ :a | a value isEmpty or: [ keep, cyclic includes: a key]].
      hasResolved := depsList select: resolveBlock.
      notResolved := depsList reject: resolveBlock.
      ordered := hasResolved collect: #key.

      [ foundDeps := notResolved select: [ :a | ordered includesAll: a value ].
        foundDeps removeAllSuchThat: [ :a | ((notResolved copyWithoutAll: foundDeps) gather: #value) asSet includes: a key ].
        notResolved := notResolved copyWithoutAll: foundDeps.
        ordered addAll: (foundDeps collect: #key).
        foundDeps isEmpty ] whileFalse.

      notResolvedNames := notResolved collect: [ :a | a key ].
      sortedByDeps := (notResolved collect: [ :a | a key -> (notResolved select: [ :b | b value includes: a key ]) size ])
        asSortedCollection: [ :a :b | a value <= b value ].
      sortedByDeps ifNotEmpty: [ cyclic add: sortedByDeps last key ].
      notResolvedNames isEmpty ] whileFalse.

    " sort packages with cyclic dependencies by count of dependencies "
    notResolvedNames := notResolved collect: [ :a | a key ].
    sortedByDeps := (notResolved collect: [ :a | a key -> (notResolved select: [ :b | b value includes: a key ]) size ])
      asSortedCollection: [ :a :b | a value <= b value ].

    " remove extension methods of packages with cyclic dependencies manually "
    FileStream stdout lf; nextPutAll: 'Removing messages...'; lf.
    cyclic do: [ :pn | 
        (RPackageSet named: pn) extensionMethods do: [ :m | 
            FileStream stdout nextPutAll: m printString; lf.
            (Smalltalk classOrTraitNamed: m className) removeSelector: m name ] ].

    FileStream stdout lf; nextPutAll: 'Removing regular packages...'; lf.
    
    " move packages with cyclic dependencies at the end of ordered list "
    ordered := (ordered copyWithoutAll: cyclic), cyclic reversed.

    " select packages to delete, keep counted order "
    delete := ordered copyWithoutAll: keep.

    FileStream stdout nextPutAll: 'ordered: ' , ordered asString; lf; lf.
    FileStream stdout nextPutAll: 'keep: ' , keep asString; lf; lf.
    FileStream stdout nextPutAll: 'cyclic: ' , cyclic asString; lf; lf.
    FileStream stdout nextPutAll: 'delete: ' , delete asString; lf; lf.
    
    " unload packages "
    delete withIndexDo: [ :packageName :index | 
        | wc |
        wc := MCWorkingCopy forPackage: (MCPackage named: packageName).
        FileStream stdout nextPutAll: index asString , '/' , delete size asString , ' - unloading ' , packageName; lf.
        wc unload ].

    FileStream stdout nextPutAll: 'Cleaning...'; lf.

    " clean Morphic globals "
    #(ActiveEvent World ActiveWorld ActiveHand) do: [ :sym | 
        Smalltalk at: sym put: nil.
        Smalltalk removeKey: sym ].

    " Monticello still keeps some classes (why???), remove them manually "
    o := Smalltalk globals associations select: [ :a | a value isClass ].
    o := o select: [ :a | a value package name = '_UnpackagedPackage' ].
    o := o collect: #key.
    o do: [ :cn | 
        FileStream stdout nextPutAll: 'redelete ' , cn; lf.
        (Smalltalk globals at: cn) removeFromSystem ].

    " final cleaning "
    ChangeSet removeChangeSetsNamedSuchThat: [ :each | true ].
    ChangeSet resetCurrentToNewUnnamedChangeSet.
    Author reset.
    SmalltalkImage classPool at: #Tools put: nil.
    Job jobAnnouncer initialize.
    EncodedCharSet initialize.
    LanguageEnvironment resetKnownEnvironments.

    " clean object memory, maybe can be simpler"
    3 timesRepeat: [ Smalltalk garbageCollect ].
    Smalltalk globals flushClassNameCache.
    3 timesRepeat: [ 
        Smalltalk garbageCollect.
        Symbol compactSymbolTable ].
    HashedCollection rehashAll.
    SmalltalkImage current fixObsoleteReferences.
    3 timesRepeat: [ Smalltalk garbageCollect ].

    UIManager default progressBarEnabled: true.
    
    FileStream stdout nextPutAll: 'DONE'; lf.

    Smalltalk saveImageInNewContext. 

    ] ifError: [ :e | 
      | rep |
      rep := FileStream forceNewFileNamed: 'PharoDebug.log'.
      rep nextPutAll: 'info.st'; cr.
      rep nextPutAll: 'Error:'; cr.
      rep nextPutAll: e asString; cr.
      rep nextPutAll: thisContext stack size asString.
      thisContext stack copy
        withIndexDo: [ :stck :i | 
          [ 
          rep nextPutAll: i asString; space; nextPutAll: stck asString; cr ] ifError: [  ] ].
      rep close.
      Smalltalk exitFailure ]
] fork.

