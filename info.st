
[

| info lines dict unimplemented sends unsent o kernelPackages networkPackages 
goferPackages pkgs allImplementedMessagesWithout allSentMessagesWithout |

SmalltalkImage current fixObsoleteReferences.
Smalltalk garbageCollect.
Smalltalk garbageCollect.
Smalltalk garbageCollect.

info := FileStream forceNewFileNamed: 'info.txt'.

Undeclared removeUnreferencedKeys.

info nextPutAll: 'Undeclared:'; cr.
info nextPutAll: Undeclared asString; cr; cr.

info nextPutAll: 'Undeclared sorted by name:'; cr.


dict := IdentityDictionary new.
Smalltalk allClassesAndTraits do: [:c |
	c localSelectors do: [:sel | 
		dict at: (c compiledMethodAt: sel) put: (c -> sel)].
	c isTrait ifFalse: [
		c class localSelectors do: [:sel | 
			dict at: (c class compiledMethodAt: sel) put: (c class -> sel)]]].

lines := SortedCollection new.

Undeclared associations do: [:assoc |
  info nextPutAll: assoc key; cr.
  [
  ((assoc pointersTo) select: [:ref | ref class = CompiledMethod]) do: [:cm |
     info nextPutAll: ' - ', (dict at: cm ifAbsent: ['method not found']) asString; cr.
     lines add: (dict at: cm) key asString, ' >> ', (dict at: cm) value asString, ' (', assoc key asString, ')'. ] 
  ] ifError: [info nextPutAll: '--error--'; cr.]].

info cr; nextPutAll: 'Undeclared sorted by class:'; cr.     
lines do: [:l | info nextPutAll: l asString; cr.].

info cr.

info nextPutAll: 'Obsolete:'; cr.
info nextPutAll: SystemNavigation default obsoleteClasses asString; cr; cr.

" let the CI job fail if the amount of obsolete classes is not zero "
self assert: (SystemNavigation default obsoleteClasses size = 0).


info nextPutAll: 'Unimplemented calls size:'; space.
info nextPutAll: SystemNavigation default allUnimplementedCalls size asString.

" let the CI job fail if the amount of unimplemented calls is growing "
self assert: (SystemNavigation default allUnimplementedCalls size <= 74).

info cr; cr.
info nextPutAll: 'Unimplemented calls:'; cr; cr.

unimplemented := SystemNavigation default allUnimplementedCalls value asSortedCollection.

sends := OrderedCollection new.
unimplemented do: [:call |
  | pos |
  pos := (call findString:  ' calls: ').
  ((call allButFirst: (pos + 7)) findTokens: ' ') do: [:send |
    sends add: (send asString, ' calledBy: ', (call first: pos))].
  info nextPutAll: call asString; cr.].
info cr.
info cr.
sends asSortedCollection do: [:call |
  info nextPutAll: call asString; cr.].
  
info cr; nextPutAll: 'finished...'.

info close.

SmalltalkImage current snapshot: false andQuit: true.

] ifError: [:e |
	| rep |
	rep := FileStream forceNewFileNamed: 'PharoDebug.log'.
	rep nextPutAll: 'info.st'; cr.
	rep nextPutAll: 'Error:'; cr.
	rep nextPutAll: e asString; cr.
	rep nextPutAll: thisContext stack size asString.
	thisContext stack copy withIndexDo: [:stck :i |
		[rep nextPutAll: i asString; space; nextPutAll: stck asString; cr] ifError: []].
	rep close. 
	Smalltalk exitFailure] 


