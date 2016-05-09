'From Pharo5.0 of 16 April 2015 [Latest update: #50627] on 4 March 2016 at 9:50:36.108699 am'!

!WorkingSession methodsFor: 'startup - shutdown' stamp: 'ChristopheDemarey 10/8/2015 11:37'!
stop: isImageQuitting
	Object flushDependents.
	
	self runShutdown: isImageQuitting.! !


'From Pharo5.0 of 16 April 2015 [Latest update: #50627] on 4 March 2016 at 9:09:17.706337 am'!

!Object methodsFor: 'releasing'!
release
	! !
	
'From Pharo5.0 of 16 April 2015 [Latest update: #50627] on 4 March 2016 at 9:36:52.700165 am'!

!SmalltalkImage methodsFor: 'memory space'!
garbageCollect
	"Primitive. Reclaims all garbage and answers the number of bytes of available space."
	Object flushDependents.
	^self primitiveGarbageCollect! !
	



SystemAnnouncer uniqueInstance unsubscribe: TestCase. 
RBProgramNode resetFormatter.
Smalltalk snapshot: true andQuit: true.
