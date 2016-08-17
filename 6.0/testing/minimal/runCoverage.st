| wrappers executed classes bootstrappedPackages blacklist results orig |

RBProgramNode formatterClass: BIConfigurableFormatter.

bootstrappedPackages := #(#NonInteractiveTranscript #'System-SessionManager' #'Collections-Sequenceable' #Slot 
#'System-CommandLineHandler' #'Collections-Native' #Kernel #'Ring-Core-Containers' #'FileSystem-Disk' #'Random-Core'
#UIManager #'Collections-Unordered' #Jobs #'System-BasicCommandLineHandler' #'Collections-Support' #'System-Hashing' 
#'System-Model' #Traits #'PharoBootstrap-Initialization' #'Multilingual-Encodings' 
#'System-CommandLine' #'Collections-Streams' #'System-Announcements' #'System-Support' #Files #Transcript 
#'System-Localization' #'Zinc-Resource-Meta-Core' #'AST-Core' #CodeImport #CodeExport #'System-Sources' 
#'Collections-Stack' #'Collections-Atomic' #'Collections-Arithmetic' #'Ring-Core-Kernel' 
#'Network-UUID' #'Multilingual-Languages' #'FileSystem-Core' #'Announcements-Core' 
#RingChunkImporter #'Collections-Strings' #CodeImportCommandLineHandlers #'Multilingual-TextConversion' 
#'Collections-Abstract' #'System-Changes' #'System-Finalization' #'System-Platforms' #'OpalCompiler-Core'
#'Zinc-Character-Encoding-Core' #'Collections-Weak' #'RPackage-Core).


wrappers := OrderedCollection new.
    
classes := ((bootstrappedPackages flatCollect: [ :pn | 
  (pn asPackage) classes flatCollect: [ :c | 
    { c. c class } ]  ]) asSet reject: #isTrait) asSortedCollection: [:a :b | a name <= b name].

blacklist := {
  "required methods"
  CompiledMethod>>#methodClass.
  Association>>#value.
  Behavior>>#methodDict.
  CompiledMethod>>#penultimateLiteral.
  CompiledMethod>>#literalAt:.
  CompiledMethod>>#classBinding.
  CompiledMethod>>#selector.
  CompiledMethod>>#header.
  CompiledMethod>>#objectAt:.
  CompiledMethod>>#numLiterals.
  HashedCollection>>#findElementOrNil:.
  MethodDictionary>>#at:put:.
  MethodDictionary>>#scanFor:.
  Object>>#at:.
  Object>>#basicAt:.
  Object>>#isMethodProperties.
  Object>>#at:put:.
  ProtoObject>>#isNil.
  ProtoObject>>#basicIdentityHash.
  Symbol>>#flushCache. 
 
  "called during installation"
  AdditionalMethodState>>#selector.
  AdditionalMethodState>>#isMethodProperties.
  CompiledMethod>>#flushCache.
  CompiledMethod>>#flushCache.
  HashedCollection>>#fullCheck.
  Magnitude>>#max:.
  OrderedCollection>>#do:.
  ProtoObject>>#withArgs:executeMethod:.
  TraitBehavior>>#methodDict.
  
} asOrderedCollection.


classes asSet do: [:c | 
  c localMethods do: [ :each | 
    (blacklist includes: each) 
      ifFalse: [
        each isAbstract ifFalse: [
	  wrappers add: (TestCoverage on: each) ]]]].



wrappers do: [ :each | each install ].
   
results := TestCase suite run.

wrappers do: [ :each | each uninstall ].  
   
Stdio stdout nextPutAll: (results) asString; lf.

Stdio stdout nextPutAll: 'FAILURES:'; lf.
results failures do: [:failure |
  Stdio stdout nextPutAll: ' - '; nextPutAll: (failure) asString; lf. 
  [failure debug] on: Exception do: [:exception | Stdio stdout nextPutAll: String tab; nextPutAll: (exception printStringLimitedTo: 180) withSeparatorsCompacted; lf.].
  ].

Stdio stdout nextPutAll: 'ERRORS:'; lf.
results errors do: [:error |
  Stdio stdout nextPutAll: ' - '; nextPutAll: (error) asString; lf. 
  [error debug] on: Exception do: [:exception | Stdio stdout nextPutAll: String tab; nextPutAll: (exception printStringLimitedTo: 180) asString withSeparatorsCompacted; lf.
  ((thisContext stack allButFirst: 6) first: 10)do: [:context | 
    Stdio stdout nextPutAll: String tab; nextPutAll: String tab; nextPutAll: (context printStringLimitedTo: 180) asString withSeparatorsCompacted; lf
    ]].
  Stdio stdout lf.
].

executed := wrappers select: [:each | each hasRun].

Stdio stdout nextPutAll: ('Executed: ', executed size asString, ' / ', wrappers size asString, ' (', (executed size*100/wrappers size) asFloat asString, '%)'); cr.

(wrappers select: [:each | each hasRun not ]) do: [:wrapper |
  Stdio stdout nextPutAll: wrapper name asString; lf.].


