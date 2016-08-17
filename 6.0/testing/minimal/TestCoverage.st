'From Pharo5.0 of 16 April 2015 [Latest update: #50723] on 27 April 2016 at 4:27:14.662062 pm'!
ProtoObject subclass: #TestCoverage
	instanceVariableNames: 'hasRun reference method'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TestCoverage'!
!TestCoverage commentStamp: 'LaurentLaffont 4/15/2011 20:19' prior: 0!
I wrap a method in order to detect whether it has been called or not. Then I can be used to calculate test coverage for SUnit.!


!TestCoverage methodsFor: 'actions' stamp: 'MarcusDenker 5/10/2013 00:27'!
install
	reference methodClass methodDict
		at: reference selector
		put: self! !

!TestCoverage methodsFor: 'actions' stamp: 'MarcusDenker 5/10/2013 00:27'!
uninstall
	reference methodClass methodDict
		at: reference selector
		put: method! !


!TestCoverage methodsFor: 'private' stamp: 'lr 3/30/2009 15:21'!
mark
	hasRun := true! !

!TestCoverage methodsFor: 'private' stamp: 'lr 3/30/2009 15:27'!
reference
	^ reference! !

!TestCoverage methodsFor: 'private' stamp: 'StephaneDucasse 8/9/2011 17:51'!
flushCache
	self reference selector flushCache! !

!TestCoverage methodsFor: 'private' stamp: 'lr 3/30/2009 20:26'!
doesNotUnderstand: aMessage
	^ method perform: aMessage selector withArguments: aMessage arguments! !


!TestCoverage methodsFor: 'evaluation' stamp: 'lr 3/30/2009 15:32'!
run: aSelector with: anArray in: aReceiver
	self mark; uninstall.
	^ aReceiver withArgs: anArray executeMethod: method! !


!TestCoverage methodsFor: 'initialization' stamp: 'lr 3/30/2009 15:19'!
initializeOn: aMethodReference
	hasRun := false.
	reference := aMethodReference.
	method := reference compiledMethod! !


!TestCoverage methodsFor: 'testing' stamp: 'lr 3/30/2009 15:09'!
hasRun
	^ hasRun! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

TestCoverage class
	instanceVariableNames: ''!

!TestCoverage class methodsFor: 'instance creation' stamp: 'lr 3/30/2009 15:23'!
on: aMethodReference
	^ self new initializeOn: aMethodReference! !
	
	
'From Pharo5.0 of 16 April 2015 [Latest update: #50723] on 27 April 2016 at 4:36:32.882365 pm'!

!CompiledMethod methodsFor: '*TestCoverage' stamp: 'MarcusDenker 3/8/2015 09:08'!
compiledMethod
	^self! !
	

	