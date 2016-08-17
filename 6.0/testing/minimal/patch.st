'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 9:16:23.516041 am'!

!MockSourceEditor methodsFor: 'as yet unclassified' stamp: 'PavelKrivanek 11/8/2012 13:31'!
insertAndSelect: aString at: anInteger

	text := (text first: anInteger-1), 
		(' ' , aString), 
		(text copyFrom: anInteger to: text size).
		
	selectionStart := anInteger.
	selectionEnd := anInteger + aString size ! !

	
!RPackageOrganizer methodsFor: 'private registration' stamp: 'MarcusDenker 7/16/2014 17:25'!
basicUnregisterPackage: aPackage
	"Unregister the specified package from the list of registered packages. Raise the announcement RPackageUnregistered. This is a low level action. It does not unregister the back pointer from classes to packages or any other information managed by the organizer"
	
	packages
		removeKey: aPackage name asSymbol
		ifAbsent: [ self reportExtraRemovalOf: aPackage ].
	"unregister also mc package"
	"aPackage mcPackage 
		ifNotNil: [ :mcPackage | mcPackage workingCopy unregister ]."! !
		
		
'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 9:44:59.384819 am'!

'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 9:45:58.02817 am'!

!ClassTestCase methodsFor: 'tests' stamp: 'CamilloBruni 5/1/2013 18:27'!
testClassComment
	! !

'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 10:23:21.574718 am'!

!SystemDictionaryTest methodsFor: 'problems' stamp: 'marcus.denker 7/29/2009 15:27'!
testClassComment
	! !


!ReleaseTest class methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/23/2013 20:47'!
knownProcesses
	"Return a dynamic list of know processes"
	
	"(self actualProcesses difference: self knownProcesses) do: [ :each | each suspend; terminate ]."
	
	^ {
		Processor activeProcess.	
		WeakArray runningFinalizationProcess.
		Processor backgroundProcess.
		SmalltalkImage current lowSpaceWatcherProcess.
		Delay schedulingProcess } asSet! !
		
'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 10:51:07.123524 am'!

!RBMethodNode methodsFor: 'converting' stamp: 'MarcusDenker 7/7/2015 10:22'!
asSequenceNode
	^body! !
	
	
'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 11:14:23.189588 am'!

!Float methodsFor: 'converting' stamp: 'nice 3/29/2006 01:01'!
asTrueFraction
	" Answer a fraction that EXACTLY represents self,
	  a double precision IEEE floating point number.
	  Floats are stored in the same form on all platforms.
	  (Does handle gradual underflow but not NANs.)
	  By David N. Smith with significant performance
	  improvements by Luciano Esteban Notarfrancesco.
	  (Version of 11April97)"
	| signexp positive expPart exp fraction fractionPart signedFraction result zeroBitsCount |
	self isInfinite ifTrue: [self error: 'Cannot represent infinity as a fraction'].
	self isNaN ifTrue: [self error: 'Cannot represent Not-a-Number as a fraction'].


	" Extract the sign and the biased exponent "
	signexp := (self basicAt: 1) bitShift: -20.
	positive := (signexp bitAnd: 16r800) = 0.
	expPart := signexp bitAnd: 16r7FF.

	" Extract fractional part; answer 0 if this is a true 0.0 value "
	fractionPart := (((self basicAt: 1) bitAnd: 16rFFFFF) bitShift: 32)+ (self basicAt: 2).
	( expPart=0 and: [ fractionPart=0 ] ) ifTrue: [ ^ 0  ].

	" Replace omitted leading 1 in fraction unless gradual underflow"
	fraction := expPart = 0
		ifTrue: [fractionPart bitShift: 1]
		ifFalse: [fractionPart bitOr: 16r0010000000000000].
	signedFraction := positive ifTrue: [fraction] ifFalse: [fraction negated].
	
	"Unbias exponent: 16r3FF is bias; 52 is fraction width"
	exp := 16r3FF + 52 - expPart.

	" Form the result. When exp>52, the exponent is adjusted by
	  the number of trailing zero bits in the fraction to minimize
	  the (huge) time otherwise spent in #gcd:. "
	exp negative
		ifTrue: [
			result := signedFraction bitShift: exp negated ]
		ifFalse:	[
			zeroBitsCount := fraction lowBit - 1.
			exp := exp - zeroBitsCount.
			exp <= 0
				ifTrue: [
					zeroBitsCount := zeroBitsCount + exp.
					"exp := 0."   " Not needed; exp not
refernced again "
					result := signedFraction bitShift:
zeroBitsCount negated ]
				ifFalse: [
					result := Fraction
						numerator: (signedFraction
bitShift: zeroBitsCount negated)
						denominator: (1 bitShift:
exp) ] ].

	"Low cost validation omitted after extensive testing"
	"(result asFloat = self) ifFalse: [self error: 'asTrueFraction validation failed']."
	^ result ! !
	

'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 1:55:27.67044 pm'!

!Integer methodsFor: 'bit manipulation' stamp: 'eem 1/16/2008 13:57'!
| anInteger
	^self bitOr: anInteger! !
	
!DictionaryTest methodsFor: 'requirements' stamp: 'monty 10/12/2015 23:58'!
otherDictionaryClasses
	"(DictionaryTest withAllSubclasses collect: [:each | each new classToBeTested]) asArray"
	^ {SmallDictionary. IdentityDictionary. PluggableDictionary.
		WeakValueDictionary. SystemDictionary. WeakKeyDictionary. SmallIdentityDictionary.
		WeakIdentityKeyDictionary. WeakKeyToCollectionDictionary. Dictionary}
			reject: [:each | each new species == self classToBeTested new species]! !	
	