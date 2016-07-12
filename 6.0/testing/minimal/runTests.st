

!FIFOQueueTests methodsFor: 'tests' stamp: 'Igor.Stasenko 10/16/2010 01:20'!
runValidationTest
	| q sema prio pusher feeder
		feeders crit done |

	q := AtomicSharedQueue new.
	feeders := OrderedCollection new.
	count := 0.
	sema := Semaphore new.
	crit := Semaphore forMutualExclusion.
	done := Semaphore new.
	
	prio := Processor activePriority.
	pusher := [ sema wait. 1 to: 100 do: [:i | q nextPut: i ]. ].
	feeder := [ sema wait. 
		[ q next. 
		crit critical: [count := count + 1 ]. count < 1000 ] whileTrue. done signal ].
	
	10 timesRepeat: [
		| proc |
		proc := pusher newProcess priority: prio + (7.7478) asInteger  - 5.
		proc resume.
		proc := feeder newProcess priority: prio + (2.4569) asInteger  - 10.
		feeders add: proc. 
		proc resume.		
	].

	" let them run "
	20 timesRepeat: [ sema signal ].
	Processor yield.
	
	done waitTimeoutSeconds: 10.
	 
	feeders do: [:ea | ea terminate ].
	self assert: (count = 1000 ) 
! !


!FIFOQueueTests methodsFor: 'tests' stamp: 'IgorStasenko 2/28/2011 14:42'!
testHeavyContention
	"run 10 threads, pushing new values to queue,
	and 10 threads pullung values from queue,
	at random priorities"
	
	| q sema prio pusher feeder
		feeders crit done |

	q := AtomicSharedQueue new.
	feeders := OrderedCollection new.
	count := 0.
	sema := Semaphore new.
	crit := Semaphore forMutualExclusion.
	done := Semaphore new.
	
	prio := Processor activePriority.
	pusher := [ sema wait. 1 to: 100 do: [:i | q nextPut: i ]. ].
	feeder := [ sema wait. 
		[ q next.  crit critical: [count := count + 1 ]. count < 1000 ] whileTrue. done signal ].
	
	10 timesRepeat: [
		| proc |
		proc := pusher newProcess priority: prio + (7.7478) asInteger.
		proc resume.
		
		proc := feeder newProcess priority: prio + (2.4569) asInteger.
		feeders add: proc. 
		proc resume.		
	].

	" let them run "
	20 timesRepeat: [ sema signal ].
	Processor yield.
	
	done waitTimeoutSeconds: 10.
	 
	feeders do: [:ea | ea terminate ].
	self assert: (count = 1000 ).
	self assert: q nextOrNil == nil! !

!FIFOQueueTests methodsFor: 'tests' stamp: 'Igor.Stasenko 10/16/2010 01:52'!
testHeavyContention2
	"run 10 threads, pushing new values to queue,
	and 10 threads pullung values from queue,
	at random priorities"
	
	| q sema prio pusher feeder
		feeders crit done |

	q := AtomicSharedQueue new.
	feeders := OrderedCollection new.
	count := 0.
	sema := Semaphore new.
	crit := Semaphore forMutualExclusion.
	done := Semaphore new.
	
	prio := Processor activePriority.
	pusher := [ sema wait. 1 to: 100 do: [:i | q nextPut: i ]. ].
	feeder := [ sema wait. 
		[ q waitForNewItems. q next. crit critical: [count := count + 1 ]. count < 1000 ] whileTrue. done signal ].
	
	10 timesRepeat: [
		| proc |
		proc := pusher newProcess priority: prio + (7.7478) asInteger - 5.
		proc resume.
		proc := feeder newProcess priority: prio + (2.4569) asInteger - 5.
		feeders add: proc. 
		proc resume.		
	].

	" let them run "
	20 timesRepeat: [ sema signal ].
	Processor yield.
	
	done waitTimeoutSeconds: 10.
	 
	feeders do: [:ea | ea terminate ].
	self assert: (count = 1000 ).
	self assert: q nextOrNil == nil
! !


!HeapTest methodsFor: 'testing' stamp: 'nice 3/26/2011 17:49'!
test1
	| data |

	"The first element of each array is the sort value, and the second will be updated by the heap with the index of the element within the heap."
	data :=  (1 to: 8) collect: [:i | {i*2. 0}].

	"Repeat with different data ordering."
	5 timesRepeat: [ | h |
		h := Heap new sortBlock: [:e1 :e2 | e1 first < e2 first].
		h indexUpdateBlock: [:array :index | array at: 2 put: index].

		data reversed do: [:d | h add: d].
		data do: [:d | self should: (h asArray at: d second) == d].
	]! !
	
	
!LIFOQueueTests methodsFor: 'testing' stamp: 'Igor.Stasenko 10/16/2010 04:46'!
testHeavyContention
	"run 10 threads, pushing new values to queue,
	and 10 threads pullung values from queue,
	at random priorities"
	
	| q sema prio pusher feeder
		feeders crit done count |

	q := self newQueue.
	feeders := OrderedCollection new.
	count := 0.
	sema := Semaphore new.
	crit := Semaphore forMutualExclusion.
	done := Semaphore new.
	
	prio := Processor activePriority.
	pusher := [ sema wait. 1 to: 100 do: [:i | q nextPut: i ]. ].
	feeder := [ sema wait. 
		[ q nextOrNil ifNotNil: [ crit critical: [count := count + 1 ]]. Processor yield. count < 1000 ] whileTrue. done signal ].
	
	10 timesRepeat: [
		| proc |
		proc := pusher newProcess priority: prio + (7.7478) asInteger.
		proc resume.
		"run feeders at lower priority, otherwise they won't give a chance pushers to complete,
		because queue doesn't blocks the process"
		proc := feeder newProcess priority: prio + (2.4569) asInteger  - 10.
		feeders add: proc. 
		proc resume.		
	].

	" let them run "
	20 timesRepeat: [ sema signal ].
	Processor yield.
	
	done waitTimeoutSeconds: 10.
	 
	feeders do: [:ea | ea terminate ].
	self assert: (count = 1000 ).
	self assert: q nextOrNil == nil! !
	
	
	

'From Pharo6.0 of 13 May 2016 [Latest update: #60069] on 12 July 2016 at 1:54:48.247086 pm'!

!String methodsFor: '*Text-Core' stamp: 'yo 11/3/2004 19:24'!
asText
	"Answer a Text whose string is the receiver."

	^ self! !
	
	
'From Pharo6.0 of 13 May 2016 [Latest update: #60069] on 12 July 2016 at 2:13:08.127662 pm'!

!RBParserTest methodsFor: 'accessing' stamp: 'MarcusDenker 7/30/2015 08:04'!
exampleClasses
	^ Array with: RBParser with: RBScanner with: RBProgramNode! !
	





!TestSuite methodsFor: 'running' stamp: 'StephaneDucasse 12/28/2014 12:07'!
run: aResult
	self setUp.
	[ self tests
		do: [ :each | 
			each logCr.
			each run: aResult.
			self announceTest: each.
			self changed: each ] ]
		ensure: [ self tearDown ]! !



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

Smalltalk exitSuccess.