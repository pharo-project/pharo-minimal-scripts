'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 1:28:43.72991 pm'!

!ArrayTest methodsFor: 'initialization' stamp: 'PavelKrivanek 3/22/2016 13:28'!
setUp

	
	literalArray := #(1 true 3 #four).
	selfEvaluatingArray := { 1. true. (3/4). String loremIpsum. (2 to: 4) . 5 }.
	nonSEArray1 := { 1 . Set with: 1 }.
	nonSEarray2 := { Smalltalk globals associationAt: #Array }.
	example1 := #(1 2 3 4 5) copy.
	indexArray:= {2. 3. 4.}.
	valueArray:={0. 0. 0.}.
	oldSubCollection:= {2. 3. 4.}.
	nonEmptyMoreThan1Element:= example1.
	subCollectionNotIn:= {1. 8. 3.}.
	collectionNotIncluded:= {7. 8. 9.}.
	removedCollection:=  { 2. 4. }.
	
	example2 := {1. 2. 3/4. 4. 5}.
	collectionWith4Elements := #(1 -2 3 1). 
	collectionWithoutNil := #( 1 2 3 4).
	simpleCollection := #( 1 8 3).
	collectionOfCollectionsOfInts := { 1. { 2. 3 }. { 4. { 5. 6} } }.
	collectionOfCollectionsOfStrings:= {{{'foo'}. {'bar'}}. 'zorg'}.
	collectResult := {SmallInteger. SmallInteger. SmallInteger. SmallInteger.}.
	empty := #().
	duplicateElement := 5.2.
	withEqualElements := {1.5. duplicateElement . 6.1. 2.0. duplicateElement .} .
	withoutEqualElements := {1.1. 4.4. 6.5. 2.4. 3.1.}.
	withCharacters := {$a. $x. $d. $c. $m.}.
	unsortedCollection := {1. 2.  8. 5. 6. 7.}.
	sortedInAscendingOrderCollection := {1. 2. 3. 4. 5. 6.}.
	elementInForCopy:= 2.
	elementNotInForCopy:= 9.
	firstIndex:= 2.
	secondIndex:= 4.
	replacementCollection:= {4. 3. 2. 1.}.
	replacementCollectionSameSize := {5. 4. 3.}.	
	nonEmpty1Element:={ 5.}.
	collectionOfCollection:={1.5. 5.5. 6.5.}.
	collectionOfFloatWithEqualElements:={1.5. 5.5. 6.5. 1.5}.
	floatCollectionWithSameBeginingAnEnd := {1.5. 5.5. 1.5 copy}.
	collection5Elements := { 1. 2. 5. 3. 4.}.! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 1:50:05.945381 pm'!

!OCNewCompilerWithChangesFunctionalTests methodsFor: 'other-tests' stamp: 'PavelKrivanek 3/22/2016 13:49'!
testModulePrimitive
	
	| aCompiledMethod bytecode index |
	aCompiledMethod := OpalCompiler new 
	source: 'copyBitsAgain
	"Primitive. See BitBlt|copyBits, also a Primitive. Essential. See Object
	documentation whatIsAPrimitive."

	<primitive: ''primitiveCopyBits'' module: ''BitBltPlugin''>
	self primitiveFailed';
	class: MockForCompilation;
	compile.
									
	bytecode := aCompiledMethod symbolic asString substrings: String cr.
	index := 0.
	self assert: (bytecode at: (index := index + 1)) = '<primitive: ''primitiveCopyBits'' module: ''BitBltPlugin''>'.
	self assert: (bytecode at: (index := index + 1)) = '21 <8B 75 00> callPrimitive: 117'.
	self assert: (bytecode at: (index := index + 1)) = '24 <70> self'.
	self assert: (bytecode at: (index := index + 1)) = '25 <D1> send: primitiveFailed'.
	self assert: (bytecode at: (index := index + 1)) = '26 <87> pop'.
	self assert: (bytecode at: (index := index + 1)) = '27 <78> returnSelf'.	

	! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50656] on 22 March 2016 at 4:04:49.325342 pm'!

!DictionaryTest methodsFor: 'requirements' stamp: 'monty 10/12/2015 23:58'!
otherDictionaryClasses
	"(DictionaryTest withAllSubclasses collect: [:each | each new classToBeTested]) asArray"
	^ {SmallDictionary. IdentityDictionary. PluggableDictionary.
		WeakValueDictionary. SystemDictionary. WeakKeyDictionary. SmallIdentityDictionary.
		WeakIdentityKeyDictionary. WeakKeyToCollectionDictionary. Dictionary}
			reject: [:each | each new species == self classToBeTested new species]! !


| results | 

results := TestCase suite run.
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
  
